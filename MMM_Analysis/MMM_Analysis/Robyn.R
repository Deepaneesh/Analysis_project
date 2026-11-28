###############################################################################
# Robyn demo on synthetic data
# 1) Simulate 4 years of weekly marketing data with KNOWN adstock/saturation
# 2) Fit Robyn
# 3) Compare Robyn's estimated channel contribution with the ground truth
###############################################################################

# ---- 0. Setup ---------------------------------------------------------------
# install.packages(c("Robyn", "dplyr", "reticulate"))
library(Robyn)
library(dplyr)
library(reticulate)
library(tidyverse)
# Robyn needs Python + nevergrad (one-time setup)
# virtualenv_create("r-reticulate")
# py_install("nevergrad", envname = "r-reticulate")
# use_virtualenv("r-reticulate", required = TRUE)

set.seed(123)
robyn_dir <- file.path(getwd(), "robyn_output")
dir.create(robyn_dir, showWarnings = FALSE)

# ---- 1. Generate synthetic data --------------------------------------------
n <- 208 # 4 years of weekly data
dates <- seq(as.Date("2021-01-04"), by = "week", length.out = n)
wk <- 1:n

# Helpers: geometric adstock and Hill saturation
adstock_geo <- function(x, theta) {
  as.numeric(stats::filter(x, theta, method = "recursive"))
}
hill <- function(x, alpha, gamma) {
  xs <- x / max(x)
  xs^alpha / (xs^alpha + gamma^alpha)
}

# Media spend (TV is flighted, others are more continuous)
tv_S <- ifelse(sin(wk / 6) > 0.2, runif(n, 40000, 90000), runif(n, 0, 8000))
ooh_S <- runif(n, 5000, 25000)
facebook_S <- pmax(0, 20000 + 8000 * sin(wk / 10) + rnorm(n, 0, 4000))
search_S <- pmax(0, 15000 + 100 * wk / 4 + rnorm(n, 0, 3000))

# True parameters (what Robyn should try to recover)
truth <- tibble::tribble(
  ~channel     , ~theta , ~alpha , ~gamma , ~beta  ,
  "tv_S"       , 0.60   , 2.0    , 0.50   , 150000 ,
  "ooh_S"      , 0.30   , 1.5    , 0.60   ,  40000 ,
  "facebook_S" , 0.20   , 2.0    , 0.45   ,  80000 ,
  "search_S"   , 0.10   , 1.2    , 0.55   ,  60000
)

spend <- list(
  tv_S = tv_S,
  ooh_S = ooh_S,
  facebook_S = facebook_S,
  search_S = search_S
)

# True contribution of each channel = beta * hill(adstock(spend))
contrib <- sapply(truth$channel, function(ch) {
  p <- truth[truth$channel == ch, ]
  p$beta * hill(adstock_geo(spend[[ch]], p$theta), p$alpha, p$gamma)
})
colnames(contrib) <- truth$channel

# Non-media drivers
trend <- 100000 + 250 * wk
season <- 25000 * sin(2 * pi * wk / 52) + 10000 * cos(4 * pi * wk / 52)
competitor <- 50000 + 8000 * sin(wk / 15) + rnorm(n, 0, 3000)
noise <- rnorm(n, 0, 8000)

revenue <- trend + season - 0.4 * competitor + rowSums(contrib) + noise

dt_sim <- tibble(
  DATE = as.character(dates),
  revenue,
  tv_S,
  ooh_S,
  facebook_S,
  search_S,
  competitor_sales_B = competitor
)

head(dt_sim)

# ---- 2. Define Robyn inputs -------------------------------------------------
data("dt_prophet_holidays") # bundled with Robyn

media_vars <- c("tv_S", "ooh_S", "facebook_S", "search_S")

# Hyperparameter ranges (geometric adstock => thetas, plus alphas & gammas)
media_vars <- c("tv_S", "ooh_S", "facebook_S", "search_S")

hyperparameters <- list(train_size = c(0.5, 0.9))
for (v in media_vars) {
  hyperparameters[[paste0(v, "_alphas")]] <- c(0.1, 3)
  hyperparameters[[paste0(v, "_gammas")]] <- c(0.1, 1)
  hyperparameters[[paste0(v, "_thetas")]] <- c(0.1, 0.95)
}

InputCollect <- robyn_inputs(
  dt_input = dt_sim,
  dt_holidays = dt_prophet_holidays,
  date_var = "DATE",
  dep_var = "revenue",
  dep_var_type = "revenue",
  prophet_vars = c("trend", "season", "holiday"),
  prophet_country = "US",
  context_vars = "competitor_sales_B",
  paid_media_spends = media_vars,
  paid_media_vars = media_vars,
  window_start = "2021-01-04",
  window_end = as.character(max(dates)),
  adstock = "geometric",
  hyperparameters = hyperparameters
)

print(InputCollect)

# ---- 3. Train models --------------------------------------------------------
# Use iterations = 2000, trials = 5 for real work (this is the demo setting)
OutputModels <- robyn_run(
  InputCollect = InputCollect,
  cores = NULL, # use all available cores
  iterations = 2000,
  trials = 5,
  ts_validation = TRUE,
  add_penalty_factor = FALSE
)
print(OutputModels)

# ---- 4. Pareto front, clustering, one-pagers --------------------------------
OutputCollect <- robyn_outputs(
  InputCollect,
  OutputModels,
  pareto_fronts = "auto",
  csv_out = "pareto",
  clusters = TRUE,
  plot_pareto = TRUE,
  plot_folder = robyn_dir
)
print(OutputCollect)

# ---- 5. Pick a model --------------------------------------------------------
# In practice, inspect the one-pagers in `robyn_dir` and choose with business
# judgment. For this demo we take the top model of the best cluster.
top_models <- OutputCollect$clusters$models
select_model <- top_models$solID[1]
cat("Selected model:", select_model, "\n")

ExportedModel <- robyn_write(InputCollect, OutputCollect, select_model)
print(ExportedModel)

# ---- 6. Compare estimates with ground truth ---------------------------------
true_share <- colSums(contrib) / sum(colSums(contrib))

est <- OutputCollect$xDecompAgg %>%
  filter(solID == select_model, rn %in% media_vars) %>%
  transmute(channel = rn, est_share = xDecompPerc / sum(xDecompPerc))

comparison <- tibble(
  channel = media_vars,
  true_share = as.numeric(true_share[media_vars])
) %>%
  left_join(est, by = "channel") %>%
  mutate(across(c(true_share, est_share), ~ round(.x, 3)))
print(comparison)

# ---- 7. Budget allocation ---------------------------------------------------
AllocatorCollect <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  scenario = "max_response",
  channel_constr_low = 0.7,
  channel_constr_up = c(1.2, 1.5, 1.5, 1.5),
  export = FALSE
)
print(AllocatorCollect)
plot(AllocatorCollect)
