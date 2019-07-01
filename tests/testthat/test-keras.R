context("keras")

source("utils.R")

# Remove saved keras test object and test on the fly instead

# test_that("keras + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("binaryclass_keras.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("binaryclass_keras.rda")))
# })
#
# test_that("keras class + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("keras")
#   skip_if_no_keras()
#   # Load fitted model
#   suppressMessages(suppressWarnings(library(keras)))
#   load(butcher_example("binaryclass_keras.rda"))
#   suppressWarnings(keras_fit <- keras::unserialize_model(temp_object))
#   # Load testing data
#   load(butcher_example("testing_binaryclass_keras.rda"))
#   predictors <- testing_data$x_test
#   response <- testing_data$y_test
#   # Butcher
#   x <- butcher(keras_fit)
#   skip_if_tensorflow_implementation()
#   suppressWarnings(results <- keras_fit %>%
#                      evaluate(predictors, response, verbose = 0))
#   expect_equal(results$loss, 0.315841164593697)
#   expect_equal(results$acc, 0.876800000667572)
#   suppressWarnings(expected_output <- keras_fit %>%
#                      predict(predictors[1:5, ]))
#   expect_equal(x %>% predict(predictors[1:5, ]), expected_output)
# })

test_that("keras + predict() works", {
  skip_on_cran()
  skip_if_not_installed("keras")
  skip_if_no_keras()
  skip_if_not_installed("parsnip")
  # Load
  library(parsnip)
  library(keras)
  # Data
  boston <- dataset_boston_housing()
  c(c(train_data, train_labels), c(test_data, test_labels)) %<-% boston
  # Fit
  reg_keras <- keras_model_sequential() %>%
    layer_dense(units = 64, activation = "relu",
                input_shape = dim(train_data)[[2]]) %>%
    layer_dense(units = 64, activation = "relu") %>%
    layer_dense(units = 1)
  reg_keras %>% compile(
    optimizer = "rmsprop",
    loss = "mse",
    metrics = c("mae")
  )
  val_indices <- 1:100
  x_val <- train_data[val_indices, ]
  x_train <- train_data[-val_indices, ]
  y_val <- train_labels[val_indices]
  y_train <- train_labels[-val_indices]
  reg_keras %>% fit(
    x_train,
    y_train,
    epochs = 4,
    batch_size = 512,
    validation_data = list(x_val, y_val)
  )
  # Predict
  expected_output <- reg_keras %>% predict(test_data)
  # Butcher
  x <- butcher(reg_keras)
  expect_equal(class(x)[1], "keras.engine.sequential.Sequential")
  new_output <- x %>% predict(test_data)
  expect_equal(new_output, expected_output)
})
