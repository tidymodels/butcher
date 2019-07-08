context("find")

test_that("find works", {
  load(butcher_example("lm.rda"))
  expect_equal(find(lm_fit$fit, "env"), "x$terms")
  expect_equal(find(lm_fit$fit, "call"), "x$call")
  expect_equal(find(lm_fit$fit, "fitted"), c("x$fitted.values", "x$residuals"))
  expect_error(find(lm_fit$fit, "whatever"))
})
