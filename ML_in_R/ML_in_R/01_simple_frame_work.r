# Simple Tidymodels Example
library(tidymodels)

# 1. Data
data(iris)

iris <- iris |>
  mutate(Species = as.factor(Species))


# 2. Train/Test Split
set.seed(123)

data_split <- initial_split(
  iris,
  prop = 0.8,
  strata = Species
)

train_data <- training(data_split)
test_data <- testing(data_split)


# 3. Recipe
data_recipe <- recipe(
  Species ~ .,
  data = train_data
)


# 4. Model specification
rf_spec <- rand_forest(
  trees = 500
) |>
  set_engine("ranger") |>
  set_mode("classification")


# 5. Workflow
rf_workflow <- workflow() |>
  add_recipe(data_recipe) |>
  add_model(rf_spec)


# 6. Fit model
rf_fit <- rf_workflow |>
  fit(data = train_data)


# 7. Predict on test data
test_predictions <- predict(
  rf_fit,
  new_data = test_data
) |>
  bind_cols(test_data)


# 8. Evaluate
accuracy(
  test_predictions,
  truth = Species,
  estimate = .pred_class
)
