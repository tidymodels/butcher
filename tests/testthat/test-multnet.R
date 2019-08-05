context("multnet")

test_that("multnet + predict() works", {
  skip_on_cran()
  skip_if_not_installed("glmnet")
  library(glmnet)
  set.seed(1234)
  predictrs <- matrix(rnorm(100*20), ncol = 20)
  response <- as.factor(sample(1:4, 100, replace = TRUE))
  fit <- glmnet(predictrs, response, family = "multinomial")
  x <- axe_call(fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- butcher(fit)
  expect_equal(predict(fit, newx = predictrs[1:3, ], s = 1),
               predict(x, newx = predictrs[1:3, ], s = 1))
})
