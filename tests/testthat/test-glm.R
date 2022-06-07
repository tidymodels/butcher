test_that("glm + axe_call() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- axe_call(glm_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("glm + axe_data() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- axe_data(glm_fit)
  expect_equal(x$data, data.frame(NA))
  expect_equal(x$y, numeric(0))
})

test_that("glm + axe_env() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- axe_env(glm_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("glm + axe_fitted() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- axe_fitted(glm_fit)
  expect_equal(x$fitted.values, numeric(0))
})

test_that("glm + butcher() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- butcher(glm_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(x$fitted.values, numeric(0))
  expect_equal(class(x)[1], "butchered_glm")
})

test_that("glm + predict() works", {
  glm_fit <- glm(mpg ~ ., data = mtcars)
  x <- butcher(glm_fit)
  expect_equal(predict(x)[1], predict(glm_fit)[1])
})
