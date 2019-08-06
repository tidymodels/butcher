context("elnet")

test_that("elnet + predict() works", {
  skip_on_cran()
  skip_if_not_installed("glmnet")
  library(glmnet)
  elnet_fit <- glmnet(x = as.matrix(mtcars[, c(1, 5, 6)]),
                      y = mtcars$hp,
                      alpha = 0)
  x <- butcher(elnet_fit)
  new_data <- as.matrix(mtcars[1:3, c(1, 5, 6)])
  expect_equal(predict(x, new_data),
               predict(elnet_fit, new_data))
  x <- axe_call(elnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

