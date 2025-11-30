skip_if_not_installed("dbarts")
skip_if_not_installed("parsnip")

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
  expect_equal(
    mean(predict(x, newdata = head(mtcars), type = "ppd")),
    mean(predict(res, newdata = head(mtcars), type = "ppd")),
    tolerance = 0.1
  )
})

test_that("bart() from parsnip + predict() works", {
  library(parsnip)
  spec <- bart(mode = "regression", trees = 5)
  res <- fit(spec, mpg ~ ., mtcars)
  x <- butcher(res)

  expect_equal(
    mean(predict(x, new_data = head(mtcars))$.pred),
    mean(predict(res, new_data = head(mtcars))$.pred),
    tolerance = 0.1
  )
  expect_equal(
    mean(predict(x, new_data = head(mtcars), type = "conf_int")$.pred_lower),
    mean(predict(res, new_data = head(mtcars), type = "conf_int")$.pred_lower),
    tolerance = 0.1
  )
  expect_equal(
    mean(predict(x, new_data = head(mtcars), type = "pred_int")$.pred_lower),
    mean(predict(res, new_data = head(mtcars), type = "pred_int")$.pred_lower),
    tolerance = 0.1
  )
})
