context("kknn")

library(kknn)

test_that("kknn + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("kknn.rda" %in% example_files)
  expect_true(file.exists(butcher_example("kknn.rda")))
})

load(butcher_example("kknn.rda"))

test_that("kknn + predict() works", {
  x <- butcher(kknn_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(x$fitted.values, list(NULL))
  new_data <- data.frame(Age = c(42, 71), Number = c(7, 3), Start = c(6, 5))
  expect_equal(predict(x, new_data), structure(2:1, .Label = c("absent", "present"), class = "factor"))
  expected_output <- predict(kknn_fit$fit, new_data, type = "prob")
  expect_equal(predict(x, new_data, type = "prob"), expected_output)
  # Should break if data removed
  x$data <- data.frame(NA)
  expect_error(predict(x, new_data, type = "prob"))
})
