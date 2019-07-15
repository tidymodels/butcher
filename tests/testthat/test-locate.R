context("locate")

test_that("locate works", {
  load(butcher_example("lm.rda"))
  expect_equal(locate(lm_fit$fit, "env"), "x$terms")
  expect_equal(locate(lm_fit$fit, "call"), "x$call")
  expect_equal(locate(lm_fit$fit, "fitted"), c("x$fitted.values", "x$residuals"))
  expect_error(locate(lm_fit$fit, "whatever"))
})
