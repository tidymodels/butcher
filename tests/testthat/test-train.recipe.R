context("train.recipe")

# Train objects are large so create on the fly
# test_that("train + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("train.recipe.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("train.recipe.rda")))
# })

test_that("train + predict() works", {
  skip_on_cran()
  skip_if_not_installed("caret")
  skip_if_not_installed("recipes")
  skip_if_not_installed("dplyr")
  skip_if_not_installed("QSARdata")
  # Load
  library(caret)
  library(recipes)
  library(dplyr)
  library(QSARdata)
  # Data
  data(AquaticTox)
  tox <- AquaticTox_moe2D
  tox$Activity <- AquaticTox_Outcome$Activity # Add the outcome variable
  # Create an additional helper variable for performance measure
  tox <- tox %>%
    select(-Molecule) %>%
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
  tox_recipe <- recipe(Activity ~ ., data = tox) %>%
    add_role(manufacturability, new_role = "performance var") %>%
    step_nzv(all_predictors()) %>%
    step_pca(contains("VSA"), prefix = "surf_area_", threshold = .95) %>%
    step_corr(all_predictors(), -starts_with("surf_area"), threshold = .90) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors())
  # Model
  set.seed(888)
  tox_ctrl <- trainControl(method = "cv", summaryFunction = model_stats)
  train.recipe_fit <- train(tox_recipe, tox,
                            method = "svmRadial",
                            metric = "wRMSE",
                            maximize = FALSE,
                            tuneLength = 10,
                            trControl = tox_ctrl)
  # Butcher
  x <- butcher(train.recipe_fit)
  # Testing data
  tox <- AquaticTox_moe2D %>%
    mutate(manufacturability  = 1/moe2D_Weight) %>%
    mutate(manufacturability = manufacturability/sum(manufacturability)) %>%
    slice(1:3)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$control, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_identical(attr(x$recipe$steps[[1]]$terms[[1]], ".Environment"), rlang::empty_env())
  expect_equal(x$pred, list(NULL))
  # expect_equal(rlang::get_env(x$modelInfo$grid), rlang::base_env())
  expect_equal(round(predict(x, newdata = tox), 2), c(5.16, 3.25, 3.27))
})
