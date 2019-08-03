context("ksvm")

test_that("ksvm + axe_() works", {
  skip_on_cran()
  skip_if_not_installed("parsnip")
  skip_if_not_installed("kernlab")
  # Load
  library(parsnip)
  library(kernlab)
  # Data
  data(spam)
  # Fit
  ksvm_class <- svm_poly(mode = "classification") %>%
    set_engine("kernlab") %>%
    fit(type ~ ., data = spam)
  x <- axe_call(ksvm_class)
  expect_equal(x@kcall, rlang::expr(dummy_call()))
  x <- axe_fitted(ksvm_class)
  expect_equal(x@fitted, numeric(0))
  x <- axe_data(ksvm_class)
  expect_equal(x@ymatrix, numeric(0))
  x <- butcher(ksvm_class)
  # Predict
  expected_output <- predict(ksvm_class$fit, spam[,-58])
  new_output <- predict(x, spam[,-58])
  expect_equal(new_output, expected_output)
})
