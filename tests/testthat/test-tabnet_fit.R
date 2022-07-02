test_that("tabnet_fit + axe_fitted() works", {
  skip_on_cran()
  skip_if_not_installed("tabnet")
  suppressPackageStartupMessages(library(parsnip))
  # Create model and fit
  tabnet_fit <- tabnet::tabnet(epochs = 10) %>%
    set_mode("regression") %>%
    set_engine("torch") %>%
    fit(mpg ~ ., data = mtcars)

  expect_error(axed_out <- axe_fitted(tabnet_fit, verbose = TRUE), NA)
  expect_lt(lobstr::obj_size(axed_out),lobstr::obj_size(tabnet_fit))
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

  expect_error(tabnet_out <- butcher(tabnet_fit, verbose = TRUE), NA)
})

test_that("tabnet_fit + predict() works", {
  skip_on_cran()
  skip_if_not_installed("tabnet")
  suppressPackageStartupMessages(library(parsnip))
  # Create model and fit
  tabnet_fit <- tabnet::tabnet(epochs = 10) %>%
    set_mode("regression") %>%
    set_engine("torch") %>%
    fit(mpg ~ ., data = mtcars)

  tabnet_out <- butcher(tabnet_fit, verbose = TRUE)
  new_data <- as.matrix(mtcars[1:3, 2:11])
  expect_equal(predict(tabnet_out,new_data), predict(tabnet_fit, new_data))
})
