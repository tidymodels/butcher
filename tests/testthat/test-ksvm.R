test_that("ksvm + axe_() works", {
  skip_on_cran()
  skip_if_not_installed("parsnip")
  skip_if_not_installed("kernlab")
  # Load
  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(kernlab))
  # Data
  data(spam)
  # Fit

  # Suppress cat() message about "Setting default kernel parameters"
  capture.output({
    ksvm_class <- svm_poly(mode = "classification") %>%
      set_engine("kernlab") %>%
      fit(type ~ ., data = spam)
  })

  x <- axe_call(ksvm_class)
  expect_equal(x$fit@kcall, rlang::expr(dummy_call()))
  x <- axe_fitted(ksvm_class)
  expect_equal(x$fit@fitted, numeric(0))
  x <- axe_data(ksvm_class)
  expect_equal(x$fit@ymatrix, numeric(0))
  x <- butcher(ksvm_class)
  # Predict
  expected_output <- predict(ksvm_class, spam[,-58])
  new_output <- predict(x, spam[,-58])
  expect_equal(new_output, expected_output)
})
