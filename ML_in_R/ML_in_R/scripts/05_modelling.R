# ============================================================
# 1. Load packages
# ============================================================

library(tidymodels)
library(workflowsets)
library(vip)


# ============================================================
# 2. Data splitting
# ============================================================

set.seed(123)

data_split <- initial_split(
  data,
  prop = 0.80,
  strata = species
)

train_data <- training(data_split)
test_data  <- testing(data_split)


# ============================================================
# 3. Data preprocessing
# ============================================================

data_recipe <- recipe(
  species ~ .,
  data = train_data
) |>
  step_normalize(all_numeric_predictors())


# ============================================================
# 4. Model specifications
# ============================================================

# XGBoost
xgboost_spec <- boost_tree(
  trees = tune(),
  tree_depth = tune(),
  learn_rate = tune(),
  min_n = tune(),
  loss_reduction = tune(),
  sample_size = tune(),
  stop_iter = tune()
) |>
  set_engine("xgboost") |>
  set_mode("classification")


# Multinomial Logistic Regression
glmnet_spec <- multinom_reg(
  penalty = tune(),
  mixture = tune()
) |>
  set_engine("glmnet") |>
  set_mode("classification")


# Random Forest
random_forest_spec <- rand_forest(
  mtry = tune(),
  min_n = tune()
) |>
  set_engine("randomForest") |>
  set_mode("classification")


# ============================================================
# 5. Create workflow set
# ============================================================

model_workflows <- workflow_set(
  preproc = list(
    recipe = data_recipe
  ),
  models = list(
    xgboost = xgboost_spec,
    glmnet = glmnet_spec,
    random_forest = random_forest_spec
  )
)


# Check workflow IDs
model_workflows$wflow_id


# ============================================================
# 6. Cross-validation
# ============================================================

set.seed(123)

cv_folds <- vfold_cv(
  train_data,
  v = 5,
  strata = species
)


# ============================================================
# 7. Define metrics
# ============================================================

classification_metrics <- metric_set(
  accuracy,
  kap,
  roc_auc
)


# ============================================================
# 8. Tune all workflows
# ============================================================

set.seed(123)

tuned_models <- workflow_map(
  model_workflows,
  resamples = cv_folds,
  grid = 10,
  metrics = classification_metrics,
  verbose = TRUE
)


# ============================================================
# 9. Compare model performance
# ============================================================

model_comparison <- tuned_models |>
  collect_metrics() |>
  filter(.metric == "accuracy") |>
  group_by(wflow_id) |>
  slice_max(
    order_by = mean,
    n = 1
  ) |>
  ungroup() |>
  arrange(desc(mean))

model_comparison


# ============================================================
# 10. Automatically select the best workflow
# ============================================================

best_workflow_id <- tuned_models |>
  collect_metrics() |>
  filter(.metric == "accuracy") |>
  group_by(wflow_id) |>
  slice_max(
    order_by = mean,
    n = 1
  ) |>
  ungroup() |>
  arrange(desc(mean)) |>
  head(1) |>
  pull(wflow_id)

best_workflow_id


# ============================================================
# 11. Extract results for the best workflow
# ============================================================

best_workflow_results <- tuned_models |>
  extract_workflow_set_result(best_workflow_id)


# ============================================================
# 12. Select best hyperparameters
# ============================================================

best_params <- best_workflow_results |>
  select_best(
    metric = "accuracy"
  )

best_params


# ============================================================
# 13. Finalize the best workflow
# ============================================================

final_workflow <- tuned_models |>
  extract_workflow(best_workflow_id) |>
  finalize_workflow(best_params)


# ============================================================
# 14. Final evaluation on test data
# ============================================================

final_results <- final_workflow |>
  last_fit(
    split = data_split,
    metrics = classification_metrics
  )


# ============================================================
# 15. Final test metrics
# ============================================================

final_metrics <- final_results |>
  collect_metrics()

final_metrics


# ============================================================
# 16. Collect test predictions
# ============================================================

test_predictions <- final_results |>
  collect_predictions()

test_predictions


# ============================================================
# 17. Confusion matrix
# ============================================================

test_predictions |>
  conf_mat(
    truth = species,
    estimate = .pred_class
  )


# ============================================================
# 18. Confusion matrix heatmap
# ============================================================

test_predictions |>
  conf_mat(
    truth = species,
    estimate = .pred_class
  ) |>
  autoplot(type = "heatmap")


# ============================================================
# 19. ROC Curve
# ============================================================

test_predictions |>
  roc_curve(
    truth = species,
    .pred_class,
    estimator = "hand_till"
  ) |>
  autoplot()


# ============================================================
# 20. Fit final model on training data
# ============================================================

final_model <- final_workflow |>
  fit(data = train_data)


# ============================================================
# 21. Extract fitted parsnip model
# ============================================================

fitted_model <- final_model |>
  extract_fit_parsnip()


# ============================================================
# 22. Variable importance
# ============================================================

fitted_model |>
  vip()


# ============================================================
# 23. New data
# ============================================================

new_data <- tibble(
  # Add your predictor values here
)


# ============================================================
# 24. Predict class
# ============================================================

predict(
  final_model,
  new_data = new_data,
  type = "class"
)


# ============================================================
# 25. Predict probabilities
# ============================================================

predict(
  final_model,
  new_data = new_data,
  type = "prob"
)

saveRDS(final_model,
        save_with_date(path = 'model',
                       filename = 'iris.rds'))
