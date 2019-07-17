context("rpart")

test_that("rpart + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("rpart.rda" %in% example_files)
  expect_true(file.exists(butcher_example("rpart.rda")))
})

test_that("rpart + axe_data() works", {
  skip_on_cran()
  skip_if_not_installed("rpart")
  library(rpart)
  fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
               x = TRUE, y = TRUE)
  x <- axe_data(fit)
  expect_equal(predict(x), predict(fit))
  x <- axe_call(fit)
  expect_error(summary(x))
  x <- axe_ctrl(fit)
  expect_equal(x$control$usesurrogate, fit$control$usesurrogate)
  x <- axe_env(fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("rpart + predict() works", {
  skip_on_cran()
  skip_if_not_installed("rpart")
  load(butcher_example("rpart.rda"))
  x <- butcher(rpart_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$functions, rlang::expr(dummy_call()))
  expect_true("usesurrogate" %in% names(x$control))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(predict(x)[1], c(`Mazda RX4 Wag` = 24.1777777777778))
  expect_equal(predict(x, newdata = mtcars[4, 2:11]), c(`Hornet 4 Drive` = 15.28))
})
