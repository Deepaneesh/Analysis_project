
# Libraries ---------------------------------------------------------------

library(leaps)
library(tidyverse)
library(janitor)
library(RVD)
library(relaimpo) # shapley 
library(rwa)

model <- lm(
  sales ~ tv + digital + radio + price,
  data = data
)

summary(model)

leaps_model <- regsubsets(
  sales ~ tv + digital + radio + price,
  data = data
)

leaps_summary <- summary(leaps_model)

leaps_summary$rsq %>% which.max()

coef(leaps_model,4)

shapley_result <- calc.relimp(
  model,
  type = c("lmg", "last", "first", "betasq", "pratt", "genizi", "car") ,
  rela = TRUE
)

shapley_result

rwa_result <- rwa(
  data,
  outcome = "sales",
  predictors = c(
    "tv",
    "digital",
    "radio",
    "price"
  ),
  applysigns = TRUE
)

rwa_result
