context("c5")

test_that("c5 + predict() works", {
  skip_on_cran()
  skip_if_not_installed("C50")
  library(C50)
  data(churn)
  c5_fit <- C5.0(x = churnTrain[, -20], y = churnTrain$churn)
  x <- axe_call(c5_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_ctrl(c5_fit)
  expect_equal(x$control, list(NULL))
  x <- axe_fitted(c5_fit)
  expect_equal(x$output, character(0))
  x <- butcher(c5_fit)
  expect_equal(predict(x, churnTest),
               predict(c5_fit, churnTest))
  expect_equal(predict(x, churnTest, type = "prob"),
               predict(c5_fit, churnTest, type = "prob"))
})
