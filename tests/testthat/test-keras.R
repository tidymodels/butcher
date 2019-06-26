context("keras")

library(keras)

test_that("keras + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("binaryclass_keras.rda" %in% example_files)
  expect_true(file.exists(butcher_example("binaryclass_keras.rda")))
})

load(butcher_example("binaryclass_keras.rda"))
keras_fit <- unserialize_model(temp_object)
load(butcher_example("testing_binaryclass_keras.rda"))
predictors <- testing_data$x_test
response <- testing_data$y_test

test_that("keras class + predict() works", {
  x <- butcher(keras_fit)
  results <- keras_fit %>% evaluate(predictors, response)
  expect_equal(results$loss, 0.315841164593697)
  expect_equal(results$acc, 0.876800000667572)
  expected_output <- keras_fit %>% predict(predictors[1:5, ])
  expect_equal(x %>% predict(predictors[1:5, ]), expected_output)
})
