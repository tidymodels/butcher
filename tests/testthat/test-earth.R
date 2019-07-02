context("earth")

test_that("earth + axe_() works", {
  skip_on_cran()
  skip_if_not_installed("parsnip")
  skip_if_not_installed("earth")
  # Load
  library(parsnip)
  library(earth)
  # Fit
  earth_fit <- mars(mode = "regression") %>%
    set_engine("earth") %>%
    fit(Volume ~ ., data = trees)
  # Butcher
  x <- butcher(earth_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$residuals, numeric(0))
  expect_equal(x$x, data.frame(NA))
  expect_equal(x$y, numeric(0))
  # Predict
  expected_output <- predict(earth_fit$fit, trees[1:3,])
  new_output <- predict(x, trees[1:3,])
  expect_equal(new_output, expected_output)
})
