context("rpart")

test_that("rpart + axe_data() works", {
  skip_on_cran()
  skip_if_not_installed("rpart")
  library(rpart)
  fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
               x = TRUE, y = TRUE)
  x <- axe_data(fit)
  expect_equal(predict(x), predict(fit))
  x <- axe_call(fit)
  expect_error(capture.output(summary(x)))
  x <- axe_ctrl(fit)
  expect_equal(x$control$usesurrogate, fit$control$usesurrogate)
  x <- axe_env(fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("rpart + predict() works", {
  skip_on_cran()
  skip_if_not_installed("rpart")
  library(rpart)
  rpart_fit <- rpart(mpg ~ .,
                     data = mtcars,
                     minsplit = 5,
                     cp = 0.1)
  x <- butcher(rpart_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$functions, rlang::expr(dummy_call()))
  expect_true("usesurrogate" %in% names(x$control))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(predict(x), predict(rpart_fit))
  expect_equal(predict(x, newdata = mtcars[4, 2:11]),
               predict(rpart_fit, newdata = mtcars[4, 2:11]))
})
