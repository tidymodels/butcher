context("earth")

test_that("parsnip + earth + axe_() works", {
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
  x <- axe_call(earth_fit)
  expect_equal(x$fit$call, rlang::expr(dummy_call()))
  expect_error(update(x))
  x <- axe_fitted(earth_fit)
  expect_equal(x$fit$residuals, numeric(0))
  x <- axe_data(earth_fit)
  # parsnip uses the formula interface for earth (#157)
  expect_equal(x$fit$data, data.frame(NA))
  expect_equal(residuals(x$fit), residuals(earth_fit$fit))
  x <- butcher(earth_fit)
  expect_equal(format(x$fit), format(earth_fit$fit))
  # Predict
  expected_output <- predict(earth_fit, trees[1:3,])
  new_output <- predict(x, trees[1:3,])
  expect_equal(new_output, expected_output)
})

test_that("earth + axe_() works", {
  skip_on_cran()
  skip_if_not_installed("earth")
  # Load
  library(earth)
  # Fit
  earth_mod <- earth(Volume ~ ., data = trees)
  # Butcher
  x <- axe_call(earth_mod)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_error(update(x))
  x <- axe_fitted(earth_mod)
  expect_equal(x$residuals, numeric(0))
  expect_warning(expect_error(residuals(x)))
  x <- axe_data(earth_mod)
  expect_equal(x, earth_mod)
  expect_equal(class(x), class(earth_mod))
  x <- butcher(earth_mod)
  expect_equal(format(x), format(earth_mod))
  # Predict
  expected_output <- predict(earth_mod, trees[1:3,])
  new_output <- predict(x, trees[1:3,])
  expect_equal(new_output, expected_output)
})
