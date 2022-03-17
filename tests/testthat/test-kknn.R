test_that("kknn + predict() works", {
  skip_on_cran()
  skip_if_not_installed("kknn")
  suppressPackageStartupMessages(library(kknn))
  m <- dim(iris)[1]
  val <- sample(1:m,
                size = round(m/3),
                replace = FALSE,
                prob = rep(1/m, m))
  iris.learn <- iris[-val,]
  iris.valid <- iris[val,]
  kknn_fit <- kknn(Species ~ .,
                   iris.learn,
                   iris.valid,
                   distance = 1,
                   kernel = "triangular")
  x <- axe_call(kknn_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(kknn_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  x <- axe_fitted(kknn_fit)
  expect_equal(x$fitted.values, list(NULL))
  x <- butcher(kknn_fit)
  new_data <- data.frame(iris[c(1,10, 13), 1:4])
  expect_equal(predict(x, new_data, type = "prob"),
               predict(kknn_fit, new_data, type = "prob"))
  expect_error(predict(x, new_data))
})
