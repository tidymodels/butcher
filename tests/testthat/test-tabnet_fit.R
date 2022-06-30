test_that("tabnet_fit + axe_call() works", {
  skip_on_cran()
  skip_if_not_installed("tabnet")
  suppressPackageStartupMessages(library(parsnip))
  # Create model and fit
  tabnet_fit <- tabnet::tabnet(epochs = 10) %>%
    set_mode("regression") %>%
    set_engine("torch") %>%
    fit(mpg ~ ., data = mtcars)

  axed_out <- axe_call(tabnet_fit, verbose = TRUE)
})

test_that("tabnet_fit + axe_fitted() works", {
  skip_on_cran()
  skip_if_not_installed("tabnet")
  suppressPackageStartupMessages(library(parsnip))
  # Create model and fit
  tabnet_fit <- tabnet::tabnet(epochs = 10) %>%
    set_mode("regression") %>%
    set_engine("torch") %>%
    fit(mpg ~ ., data = mtcars)

  axed_out <- axe_fitted(tabnet_fit, verbose = TRUE)
})

test_that("tabnet_fit + butcher() works", {
  skip_on_cran()
  skip_if_not_installed("tabnet")
  suppressPackageStartupMessages(library(parsnip))
  # Create model and fit
  tabnet_fit <- tabnet::tabnet(epochs = 10) %>%
    set_mode("regression") %>%
    set_engine("torch") %>%
    fit(mpg ~ ., data = mtcars)

  tabnet_out <- butcher(tabnet_fit, verbose = TRUE)
})

test_that("tabnet_fit + predict() works", {
})
