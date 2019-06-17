context("lm")

test_that("lm + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("lm.rda" %in% example_files)
  expect_true(file.exists(butcher_example("lm.rda")))
})

load(butcher_example("lm.rda"))

test_that("lm + axe_call() works", {
  x <- axe_call(lm_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("lm + axe_env() works", {
  x <- axe_env(lm_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::empty_env())
})

test_that("lm + axe_fitted() works", {
  x <- axe_fitted(lm_fit)
  expect_equal(x$fitted.values, numeric(0))
})

test_that("lm + axe() works", {
  x <- axe(lm_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::empty_env())
  expect_equal(x$fitted.values, numeric(0))
  expect_equal(class(x), "butcher_lm")
})

test_that("lm + predict() works", {
  x <- axe(lm_fit)
  expect_gr(predict(x)[1], 20)
})
