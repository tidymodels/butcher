skip_if_not_installed("dbarts")

test_that("dbarts + axe_call() works", {
  res <- dbarts::bart(mtcars[,2:5], mtcars[,1], verbose = FALSE)
  x <- axe_call(res)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("dbarts + axe_fitted() works", {
  res <- dbarts::bart(mtcars[,2:5], mtcars[,1], mtcars[1:5, 2:5], verbose = FALSE)
  x <- axe_fitted(res)
  expect_equal(x$yhat.train, numeric(0))
  expect_equal(x$yhat.train.mean, numeric(0))
  expect_equal(x$yhat.test, numeric(0))
  expect_equal(x$yhat.test.mean, numeric(0))
  expect_equal(x$sigma, numeric(0))
  expect_equal(x$varcount, numeric(0))
})

test_that("dbarts + butcher() works", {
  res <- dbarts::bart(mtcars[,2:5], mtcars[,1], verbose = FALSE)
  x <- butcher(res)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$yhat.train, numeric(0))
  expect_equal(class(x)[1], "butchered_bart")
})

test_that("dbarts + predict() works", {
  res <- dbarts::bart(mtcars[,2:5], mtcars[,1], verbose = FALSE, keeptrees = TRUE)
  x <- butcher(res)
  expect_equal(
    predict(x, newdata = head(mtcars))[1],
    predict(res, newdata = head(mtcars))[1]
  )
})
