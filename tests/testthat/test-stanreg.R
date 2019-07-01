context("stanreg")

test_that("stanreg + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("stanreg.rda" %in% example_files)
  expect_true(file.exists(butcher_example("stanreg.rda")))
})

load(butcher_example("stanreg.rda"))

test_that("stanreg + axe_call() works", {
  x <- axe_call(stanreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("stanreg + axe_env() works", {
  x <- axe_env(stanreg_fit)
  test_en <- rlang::base_env()
  expect_identical(attr(x$terms, ".Environment"), test_en)
  expect_identical(attr(attributes(x$model)$terms, ".Environment"), test_en)
  expect_identical(x$stanfit@.MISC, test_en)
  expect_identical(x$stanfit@stanmodel@dso@.CXXDSOMISC, test_en)
})

test_that("stanreg + axe_fitted() works", {
  x <- axe_fitted(stanreg_fit)
  expect_equal(x$fitted.values, numeric(0))
})

test_that("stanreg + butcher() works", {
  x <- butcher(stanreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  test_en <- rlang::base_env()
  expect_identical(attr(x$terms, ".Environment"), test_en)
  expect_identical(attr(attributes(x$model)$terms, ".Environment"), test_en)
  expect_identical(x$stanfit@.MISC, test_en)
  expect_identical(x$stanfit@stanmodel@dso@.CXXDSOMISC, test_en)
  expect_equal(x$fitted.values, numeric(0))
  # expect_equal(class(x)[1], "butcher_stanreg") # TODO: Fix class assignment
})

test_that("stanreg + predict() works", {
  x <- butcher(stanreg_fit)
  expect_gt(predict(x)[1], 20)
})
