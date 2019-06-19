context("train")

# Load testing data
library(QSARdata)
library(dplyr)
library(caret)
data(AquaticTox)
tox <- AquaticTox_moe2D
tox <- tox %>%
  select(-Molecule) %>%
  mutate(manufacturability  = 1/moe2D_Weight) %>%
  mutate(manufacturability = manufacturability/sum(manufacturability)) %>%
  slice(1:3)

test_that("train + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("train.rda" %in% example_files)
  expect_true(file.exists(butcher_example("train.rda")))
})

load(butcher_example("train.rda"))

test_that("train + predict() works", {
  x <- axe(train_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$control, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_identical(attr(x$recipe$steps[[1]]$terms[[1]], ".Environment"), rlang::base_env())
  expect_equal(x$pred, list(NULL))
  expect_equal(predict(x, newdata = tox), c(5.16017632849311, 3.24955407248686, 3.27049760957205))
})
