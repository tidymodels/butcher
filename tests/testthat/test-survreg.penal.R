test_that("survreg + penalized + predict() works", {
  skip_on_cran()
  skip_if_not_installed("survival")
  suppressPackageStartupMessages(library(survival))
  fit <- survreg(
    Surv(time, status) ~ rx,
    data = rats,
    subset = (sex == "f")
  )
  x <- axe_call(fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_data(fit)
  expect_error(residuals(x))
  expect_equal(x$y, numeric(0))
  x <- axe_env(fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  x <- butcher(fit)
  expected_outcome <- predict(fit)
  expect_equal(predict(x), expected_outcome)
})
