context("nnet")

test_that("nnet + predict() works", {
  skip_on_cran()
  skip_if_not_installed("nnet")
  skip_if_not_installed("parsnip")
  library(parsnip)
  library(nnet)
  nnet_fit <- mlp("classification", hidden_units = 2) %>%
    set_engine("nnet") %>%
    fit(Species ~ ., data = iris)
  x <- axe_call(nnet_fit)
  expect_equal(x$fit$call, rlang::expr(dummy_call()))
  x <- axe_env(nnet_fit)
  expect_identical(attr(x$fit$terms, ".Environment"), rlang::base_env())
  x <- axe_fitted(nnet_fit)
  expect_equal(x$fit$fitted.values, numeric(0))
  x <- butcher(nnet_fit)
  expected_output <- predict(nnet_fit, iris[1:3, ])
  expect_equal(predict(x, iris[1:3,]), expected_output)
})
