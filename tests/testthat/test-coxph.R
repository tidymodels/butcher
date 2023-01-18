skip_if_not_installed("survival")
library(survival)

test_that("coxph + axe_env() works", {
  example_data <-
    tibble::tibble(
      time = rpois(1000, 2) + 1,
      status = rbinom(1000, 1, .5),
      x = rpois(1000, .5),
      covar = rbinom(1000, 1, .5)
    )

  res <- coxph(Surv(time, status) ~ x + strata(covar), example_data)

  x <- axe_env(res)

  expect_equal(attr(x$formula, ".Environment"), rlang::base_env())
})

test_that("coxph + axe_data() works", {
  example_data <-
    tibble::tibble(
      time = rpois(1000, 2) + 1,
      status = rbinom(1000, 1, .5),
      x = rpois(1000, .5),
      covar = rbinom(1000, 1, .5)
    )

  res <- coxph(Surv(time, status) ~ x + strata(covar), example_data)

  x <- axe_data(res)
  expect_equal(x$y, numeric(0))
})

test_that("coxph + butcher() works", {
  example_data <-
    tibble::tibble(
      time = rpois(1000, 2) + 1,
      status = rbinom(1000, 1, .5),
      x = rpois(1000, .5),
      covar = rbinom(1000, 1, .5)
    )

  res <- coxph(Surv(time, status) ~ x + strata(covar), example_data)

  x <- butcher(res)
  expect_equal(attr(x$formula, ".Environment"), rlang::base_env())
  expect_equal(x$y, numeric(0))
})

test_that("coxph + predict() works", {
  example_data <-
    tibble::tibble(
      time = rpois(1000, 2) + 1,
      status = rbinom(1000, 1, .5),
      x = rpois(1000, .5),
      covar = rbinom(1000, 1, .5)
    )

  res <- coxph(Surv(time, status) ~ x + strata(covar), example_data)

  x <- butcher(res)

  expect_equal(
    predict(x, newdata = head(example_data))[1],
    predict(res, newdata = head(example_data))[1]
  )
})
