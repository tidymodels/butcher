context("ranger")

library(ranger)

test_that("ranger + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("ranger.rda" %in% example_files)
  expect_true(file.exists(butcher_example("ranger.rda")))
})

load(butcher_example("ranger.rda"))

test_that("ranger + predict() works", {
  x <- butcher(ranger_fit)
  new_data <- iris[1:3, ]
  expect_equal(predict(x, new_data)$predictions[1,1], c(setosa = 1))
  expect_equal(predict(x, data = new_data, predict.all = TRUE)$predictions[1,1,20], 1)
})

load(butcher_example("ranger_reg.rda"))

test_that("ranger_reg + predict() works", {
  x <- butcher(ranger_reg_fit)
  new_data <- iris[1:3, ]
  expect_equal(predict(x, new_data)$predictions, c(3.57547064990565, 3.20695107226107, 3.20450937229437))
})
