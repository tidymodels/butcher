context("elnet")

library(glmnet)

test_that("elnet + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("elnet.rda" %in% example_files)
  expect_true(file.exists(butcher_example("elnet.rda")))
})

load(butcher_example("elnet.rda"))

test_that("elnet + predict() works", {
  x <- butcher(elnet_fit)
  new_data <- as.matrix(mtcars[1:3, 2:11])
  expect_equal(predict(x, new_data)[1], 22.5177880899825)
})
