context("flexsurvreg")

test_that("flexsurvreg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("flexsurv")
  library(flexsurv)
  fit <- flexsurvreg(Surv(futime, fustat) ~ age, data = ovarian, dist = "exp")
  x <- axe_call(fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(fit)
  expect_identical(attr(attributes(x$data$m)$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$concat.formula, ".Environment"), rlang::base_env())
  expect_identical(attr(x$all.formulae$rate, ".Environment"), rlang::base_env())
})

test_that("flexsurvreg markov + predict() works", {
  skip_on_cran()
  skip_if_not_installed("flexsurv")
  library(flexsurv)
  fit <- flexsurvreg(Surv(years, status) ~ trans + shape(trans),
                     data = bosms3,
                     dist = "weibull")
  x <- axe_call(fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(fit)
  expect_identical(attr(attributes(x$data$m)$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$concat.formula, ".Environment"), rlang::base_env())
  expect_identical(attr(x$all.formulae$scale, ".Environment"), rlang::base_env())
  x <- butcher(fit)
  # Obtain cumulative transition-specific hazards
  tmat <- rbind(c(NA, 1, 2), c(NA, NA, 3), c(NA, NA, NA))
  tgrid <- seq(0, 14, by = 0.1)
  expected_cul <- flexsurv::msfit.flexsurvreg(fit, t = tgrid, trans = tmat)
  expected_output <- expected_cul$Haz$Haz[1:3]
  expect_equal(flexsurv::msfit.flexsurvreg(x, t = tgrid, trans = tmat)$Haz$Haz[1:3],
               expected_output)
  # Prediction from parametric multi-state models
  set.seed(123)
  expected_output <- flexsurv::pmatrix.simfs(fit, trans = tmat, t = 5)
  set.seed(123)
  expect_equal(flexsurv::pmatrix.simfs(x, trans = tmat, t = 5), expected_output)
})

test_that("flexsurvreg + custom distribution + predict() works", {
  skip_on_cran()
  skip_if_not_installed("flexsurv")
  library(flexsurv)
  fit <- flexsurvreg(Surv(futime, fustat) ~ 1, data = ovarian, dist = "weibull")
  x <- butcher(fit)
  expect_equal(model.frame(x), model.frame(fit))
  expect_equal(model.matrix(x), model.matrix(fit))
})
