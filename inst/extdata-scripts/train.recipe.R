# Load libraries
suppressWarnings(suppressMessages(library(caret)))
suppressWarnings(suppressMessages(library(recipes)))
suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(QSARdata)))

# Load data
data(AquaticTox)
tox <- AquaticTox_moe2D
tox$Activity <- AquaticTox_Outcome$Activity # Add the outcome variable

# Create an additional helper variable for performance measure
tox <- tox %>%
  select(-Molecule) %>%
  ## Suppose the easy of manufacturability is
  ## related to the molecular weight of the compound
  mutate(manufacturability  = 1/moe2D_Weight) %>%
  mutate(manufacturability = manufacturability/sum(manufacturability))

# Helper function to calculate weights based on manufacturability
model_stats <- function(data, lev = NULL, model = NULL) {
  stats <- defaultSummary(data, lev = lev, model = model)
  wt_rmse <- function (pred, obs, wts, na.rm = TRUE)
    sqrt(weighted.mean((pred - obs)^2, wts, na.rm = na.rm))
  res <- wt_rmse(pred = data$pred,
                 obs = data$obs,
                 wts = data$manufacturability)
  c(wRMSE = res, stats)
}

# Create a recipe
tox_recipe <- recipe(Activity ~ ., data = tox) %>%
  add_role(manufacturability, new_role = "performance var") %>%
  # Remove zero variance predictors
  step_nzv(all_predictors()) %>%
  # Retain the components required to capture 95% of info
  step_pca(contains("VSA"), prefix = "surf_area_", threshold = .95) %>%
  # Avoid having predictor pairs with correlation greater than 90%
  step_corr(all_predictors(), -starts_with("surf_area"), threshold = .90) %>%
  # Center and scale
  step_center(all_predictors()) %>%
  step_scale(all_predictors())

# Create model and fit
set.seed(888)
tox_ctrl <- trainControl(method = "cv", summaryFunction = model_stats)
train.recipe_fit <- train(tox_recipe, tox,
                 method = "svmRadial",
                 metric = "wRMSE",
                 maximize = FALSE,
                 tuneLength = 10,
                 trControl = tox_ctrl)

# Save
save(train.recipe_fit, file = "inst/extdata/train.recipe.rda")
