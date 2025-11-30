skip_if_not_installed("ipred")
library(ipred)

skip_if_not_installed("survival")
library(survival)

data("DLBCL", package = "ipred")

test_that("ipred + rpart + axing works (regbagg)", {
  fit <- bagging(y ~ x, data.frame(y = rnorm(1e3), x = rnorm(1e3)))

  x <- axe_call(fit)
  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))

  x <- axe_data(x)
  expect_equal(x$y, numeric(0))
  expect_equal(x$X, data.frame(NA))

  x <- axe_env(x)
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())

  x <- axe_ctrl(x)
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)
})

test_that("ipred + rpart + axing works (classbagg)", {
  fit <-
    bagging(
      y ~ x,
      data.frame(y = factor(rep(letters[1:4], 100)), x = rnorm(4e3))
    )

  x <- axe_call(fit)
  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))

  x <- axe_data(x)
  expect_equal(x$mtrees[[1]]$btree$y, numeric(0))

  x <- axe_env(x)
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())

  x <- axe_ctrl(x)
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)
})

test_that("ipred + rpart + axing works (survbagg)", {
  fit <-
    bagging(Surv(time,cens) ~ MGEc.1 + MGEc.2 + MGEc.3 + MGEc.4 + MGEc.5 +
              MGEc.6 + MGEc.7 + MGEc.8 + MGEc.9 +
              MGEc.10 + IPI, data=DLBCL, coob=TRUE)

  x <- axe_call(fit)
  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))

  x <- axe_data(x)
  expect_equal(x$mtrees[[1]]$btree$y, numeric(0))

  x <- axe_env(x)
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())

  x <- axe_ctrl(x)
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)
})

test_that("ipred + rpart + predict() works (regbagg)", {
  fit <- bagging(y ~ x, data.frame(y = rnorm(1e3), x = rnorm(1e3)))

  x <- butcher(fit)

  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(x$mtrees[[1]]$btree$y, numeric(0))
  expect_equal(x$y, numeric(0))
  expect_equal(x$X, data.frame(NA))
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)

  expect_equal(
    predict(x, data.frame(x = 1)),
    predict(fit, data.frame(x = 1))
  )
})

test_that("ipred + rpart + predict() works (classbagg)", {
  fit <-
    bagging(
      y ~ x,
      data.frame(y = factor(rep(letters[1:4], 100)), x = rnorm(4e3))
    )

  x <- butcher(fit)

  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(x$mtrees[[1]]$btree$y, numeric(0))
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)

  expect_equal(
    predict(x, data.frame(x = 1)),
    predict(fit, data.frame(x = 1))
  )
})

test_that("ipred + rpart + predict() works (survbagg)", {
  fit <-
    bagging(Surv(time,cens) ~ MGEc.1 + MGEc.2 + MGEc.3 + MGEc.4 + MGEc.5 +
              MGEc.6 + MGEc.7 + MGEc.8 + MGEc.9 +
              MGEc.10 + IPI, data=DLBCL, coob=TRUE)

  x <- butcher(fit)

  expect_equal(x$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(x$mtrees[[1]]$btree$y, numeric(0))
  expect_identical(attr(x$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())
  expect_equal(x$mtrees[[1]]$btree$control$usesurrogate, fit$mtrees[[1]]$btree$control$usesurrogate)

  expect_equal(
    predict(x, DLBCL[1:2,]),
    predict(fit, DLBCL[1:2,])
  )
})
