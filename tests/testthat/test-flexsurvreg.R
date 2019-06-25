context("flexsurvreg")

library(flexsurv)

test_that("flexsurvreg + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("flexsurvreg.rda" %in% example_files)
  expect_true(file.exists(butcher_example("flexsurvreg.rda")))
})

load(butcher_example("flexsurvreg.rda"))

test_that("flexsurvreg + predict() works", {
  x <- butcher(flexsurvreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$data$Y, numeric(0))
  expect_identical(attr(attributes(x$data$m)$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$concat.formula, ".Environment"), rlang::base_env())
  expect_identical(attr(x$all.formulae$rate, ".Environment"), rlang::empty_env())
})

load(butcher_example("flexsurvreg_markov.rda"))

test_that("flexsurvreg markov + predict() works", {
  x <- butcher(flexsurvreg_markov_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$data$Y, numeric(0))
  expect_identical(attr(attributes(x$data$m)$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$concat.formula, ".Environment"), rlang::base_env())
  expect_identical(attr(x$all.formulae$scale, ".Environment"), rlang::empty_env())
  # Obtain cumulative transition-specific hazards
  tmat <- rbind(c(NA, 1, 2), c(NA, NA, 3), c(NA, NA, NA))
  tgrid <- seq(0, 14, by = 0.1)
  expected_cul <- msfit.flexsurvreg(flexsurvreg_markov_fit$fit,
                                    t = tgrid,
                                    trans = tmat)
  expected_output <- expected_cul$Haz$Haz[1:3]
  expect_equal(msfit.flexsurvreg(x, t = tgrid, trans = tmat)$Haz$Haz[1:3],
               expected_output)
  # Prediction from parametric multi-state models
  set.seed(123)
  expected_output <- pmatrix.simfs(flexsurvreg_markov_fit$fit, trans = tmat, t = 5)
  set.seed(123)
  expect_equal(pmatrix.simfs(x, trans = tmat, t = 5), expected_output)
})


