context("keras")

source("utils.R")

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
