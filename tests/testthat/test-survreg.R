test_that("survreg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("survival")
  suppressPackageStartupMessages(library(survival))
  survreg_fit <- survreg(Surv(futime, fustat) ~ 1, data = ovarian)
  x <- axe_call(survreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_error(model.matrix(x))
  x <- axe_data(survreg_fit)
  expect_error(residuals(x))
  expect_equal(x$y, numeric(0))
  x <- axe_env(survreg_fit)
  expect_error(model.matrix(x))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  x <- butcher(survreg_fit)
  expect_equal(predict(x, ovarian[1, 1:2])[1], c(`1` = 1225.4189589287))
  expect_equal(
    predict(survreg_fit, newdata = ovarian[1, 1:2], type = c("quantile")),
    c(160.794978494583, 2601.21611951026)
  )
  expect_equal(
    predict(survreg_fit, newdata = ovarian[1, 1:2], type = c("linear")),
    c(`1` = 7.1110380717964)
  )
  expect_equal(
    predict(survreg_fit, newdata = ovarian[1, 1:2], se.fit = TRUE)$se.fit,
    c(`1` = 358.714386983321)
  )
})
