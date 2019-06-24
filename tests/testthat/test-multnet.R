context("multnet")

library(glmnet)

test_that("multnet + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("multnet.rda" %in% example_files)
  expect_true(file.exists(butcher_example("multnet.rda")))
})

load(butcher_example("multnet.rda"))

# Note multnet is very different so it has its own predict function in
# the glmnet package.

test_that("multnet + predict() works", {
  x <- butcher(multnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(predict(x, newx = matrix(1, ncol = 20), s= 1)[1,1,1], 0.0881926426624652)
})
