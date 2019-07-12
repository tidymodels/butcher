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
  x <- butcher(nnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(x$fitted.values, numeric(0))
  expected_output <- as.matrix(predict(nnet_fit$fit, iris[1:3, ]))
  colnames(expected_output) <- NULL
  expect_equal(predict(x, iris[1:3,]), expected_output)
})
