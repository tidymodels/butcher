skip_if_not_installed("MASS")
library(MASS)

test_that("lda + axe_env() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- lda(cyl ~ ., mt)
  x <- axe_env(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("qda + axe_env() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- qda(cyl ~ ., mt)
  x <- axe_env(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("lda + butcher() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- lda(cyl ~ ., mt)
  x <- butcher(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(class(x)[1], "butchered_lda")
})

test_that("qda + butcher() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- qda(cyl ~ ., mt)
  x <- butcher(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(class(x)[1], "butchered_qda")
})

test_that("lda + predict() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- lda(cyl ~ ., mt)
  x <- butcher(res)
  expect_equal(
    predict(x, newdata = head(mt))[1],
    predict(res, newdata = head(mt))[1]
  )
})

test_that("qda + predict() works", {
  mt <- mtcars[,1:5]
  mt$cyl <- as.factor(mt$cyl)

  res <- qda(cyl ~ ., mt)
  x <- butcher(res)
  expect_equal(
    predict(x, newdata = head(mt))[1],
    predict(res, newdata = head(mt))[1]
  )
})
