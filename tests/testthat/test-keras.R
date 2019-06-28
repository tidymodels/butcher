context("keras")

source("utils.R")

test_that("keras + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("binaryclass_keras.rda" %in% example_files)
  expect_true(file.exists(butcher_example("binaryclass_keras.rda")))
})

test_that("keras class + predict() works", {
  skip_on_cran()
  skip_if_not_installed("keras")
  skip_if_no_keras()
  # Load fitted model
  suppressMessages(suppressWarnings(library(keras)))
  load(butcher_example("binaryclass_keras.rda"))
  suppressWarnings(keras_fit <- keras::unserialize_model(temp_object))
  # Load testing data
  load(butcher_example("testing_binaryclass_keras.rda"))
  predictors <- testing_data$x_test
  response <- testing_data$y_test
  # Butcher
  x <- butcher(keras_fit)
  skip_if_tensorflow_implementation()
  suppressWarnings(results <- keras_fit %>%
                     evaluate(predictors, response, verbose = 0))
  expect_equal(results$loss, 0.315841164593697)
  expect_equal(results$acc, 0.876800000667572)
  suppressWarnings(expected_output <- keras_fit %>%
                     predict(predictors[1:5, ]))
  expect_equal(x %>% predict(predictors[1:5, ]), expected_output)
})
