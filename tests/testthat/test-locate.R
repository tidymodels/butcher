context("locate")

test_that("locate works", {
  lm_fit <- lm(mpg ~ ., data = mtcars)
  expect_equal(locate(lm_fit, "env"), "x$terms")
  expect_equal(locate(lm_fit, "call"), "x$call")
  expect_equal(locate(lm_fit, "fitted"), c("x$fitted.values", "x$residuals"))
  expect_error(locate(lm_fit, "whatever"))
})
