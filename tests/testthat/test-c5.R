context("c5")

test_that("c5 + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("c5.rda" %in% example_files)
  expect_true(file.exists(butcher_example("c5.rda")))
})

test_that("c5 + predict() works", {
  skip_on_cran()
  skip_if_not_installed("C50")
  load(butcher_example("c5.rda"))
  x <- butcher(c5_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$control, list(NULL))
  new_data <- data.frame(Age = c(42, 71), Number = c(7, 3), Start = c(6, 5))
  expect_equal(predict(x, new_data),
               structure(1:2, .Label = c("absent", "present"), class = "factor"))
  expected_output <- predict(c5_fit$fit, new_data, type = "prob")
  expect_equal(predict(x, new_data, type = "prob"), expected_output)
})

test_that("c5 + predict() works", {
  skip_on_cran()
  skip_if_not_installed("C50")
  load(butcher_example("c5_boost.rda"))
  x <- butcher(boost_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$control, list(NULL))
  new_data <- iris[1:2, 1:4]
  expect_equal(predict(x, new_data),
               structure(c(1L, 1L), .Label = c("setosa", "versicolor", "virginica"), class = "factor"))
  expected_output <- predict(boost_fit$fit, new_data, type = "prob")
  expect_equal(predict(x, new_data, type = "prob"), expected_output)
})
