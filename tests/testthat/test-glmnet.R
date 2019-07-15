context("glmnet")

test_that("glmnet + predict() works", {
  skip_if_not_installed("glmnet")
  library(glmnet)
  x <- model.matrix(mpg ~ ., data = mtcars)
  y <- as.matrix(sample(c(1, 0), size = 32, replace = TRUE))
  fit <- glmnet(x, as.factor(y), family = "binomial")
  axed <- axe_call(fit)
  expect_equal(axed$call, rlang::expr(dummy_call()))
})
