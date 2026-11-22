model_metrics <- data.frame()


# Base model --------------------------------------------------------------

lm_model <- lm(data = t_mmm_data,
               formula = sales ~ .)

lm_summary <- lm_model %>% summary()

vif(lm_model)

lm_model %>% bptest()

durbinWatsonTest(lm_model)

# Leaps model 
leaps_model <- leaps::regsubsets(data = t_mmm_data,
                  sales ~.)

leaps_summary <- leaps_model %>% summary()
leaps_summary$adjr2 %>% which.max()

coef(leaps_model,8)

# Glmnet model 

glmnet_model <-  train(
  sales ~ .,
  data = t_mmm_data,
  method = 'glmnet'
)
glmnet_model
glmnet_model$metric
glmnet_model$bestTune

coef(glmnet_model$finalModel, 
     s = glmnet_model$bestTune$lambda)


shapley_result <- calc.relimp(
 lm_model,
  type = c("lmg", "last", "first", "betasq", "pratt", "genizi", "car") ,
  rela = TRUE
)

shapley_result
rwa_result <- rwa(
  t_mmm_data,
  outcome = "sales",
  predictors = c(
    "tv_sat",
    "google_sat",
    "meta_sat",
    "youtube_sat",
    "radio_sat",
    'price',
    'promotion',
    'distribution',
    'competitor_price',
    'holiday',
    'campaign',
    'trend',
    'seasonal'
  ),
  applysigns = TRUE
)

rwa_result


