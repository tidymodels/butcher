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
  expect_identical(attr(x$all.formulae$mu, ".Environment"), rlang::base_env())
  # tmat <- rbind(c(NA, 1, 2), c(NA, NA, 3), c(NA, NA, NA))
  # expect_equal(pmatrix.fs(x, t = c(5, 10), trans = tmat)$`5`[1,1], 0.29925655640147)
  # expect_equal(totlos.fs(x, t = 10, trans = tmat)[1,1], 3.77315680795681)
})

