context("train.recipe")

# Load testing data
library(QSARdata)
library(dplyr)
library(caret)
data(AquaticTox)
tox <- AquaticTox_moe2D %>%
  mutate(manufacturability  = 1/moe2D_Weight) %>%
  mutate(manufacturability = manufacturability/sum(manufacturability)) %>%
  slice(1:3)

test_that("train + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("train.recipe.rda" %in% example_files)
  expect_true(file.exists(butcher_example("train.recipe.rda")))
})

load(butcher_example("train.recipe.rda"))

test_that("train + predict() works", {
  x <- butcher(train.recipe_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$control, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_identical(attr(x$recipe$steps[[1]]$terms[[1]], ".Environment"), rlang::empty_env())
  expect_equal(x$pred, list(NULL))
  expect_equal(predict(x, newdata = tox), c(5.16049914274147, 3.2496552342837, 3.27006004500176))
})
