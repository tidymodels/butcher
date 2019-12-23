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
  # Load
  library(recipes)
  library(caret)
  library(modeldata)
  # Data
  data(biomass)
  biomass_tr <- biomass[biomass$dataset == "Training",]
  biomass_te <- biomass[biomass$dataset == "Testing",]
  recipe <- biomass %>%
    recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur) %>%
    step_center(all_predictors()) %>%
    step_scale(all_predictors()) %>%
    step_spatialsign(all_predictors())
  # Model
  train.recipe_fit <- train(recipe, biomass_tr, method = "svmRadial", metric = "RMSE")
  # Butcher
  x <- butcher(train.recipe_fit)
  # Testing data
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$control, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_identical(attr(x$recipe$steps[[1]]$terms[[1]], ".Environment"), rlang::base_env())
  expect_equal(x$pred, list(NULL))
  expected_output <- predict(train.recipe_fit, newdata = biomass_te)
  expect_equal(predict(x, biomass_te), expected_output)
})
