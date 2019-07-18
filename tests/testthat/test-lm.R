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

test_that("lm + offset + axe_call() works", {
  example <- lm(Sepal.Length ~ Sepal.Width,
                offset = rep(10, 150),
                data = iris)
  x <- axe_call(example)
  expect_equal(x$call$offset, example$call$offset)
})

test_that("lm + axe_env() works", {
  x <- axe_env(lm_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("lm + axe_fitted() works", {
  x <- axe_fitted(lm_fit)
  expect_equal(x$fitted.values, numeric(0))
})

test_that("lm + butcher() works", {
  x <- butcher(lm_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(x$fitted.values, numeric(0))
  expect_equal(class(x)[1], "butchered_lm")
})

test_that("lm + predict() works", {
  x <- butcher(lm_fit)
  expect_equal(predict(x)[1], c(`Mazda RX4` = 21.5647055857078))
  set.seed(0); w <- runif(nrow(trees), 1, 2)
  X <- model.matrix(~ Girth + Volume, trees)
  y <- trees$Height
  fit_by_wls <- lm(y ~ X - 1, weights = w)
  x <- axe_env(fit_by_wls)
  expect_lt(lobstr::obj_size(fit_by_wls), lobstr::obj_size(x))
})
