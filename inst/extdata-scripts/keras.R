# Instantiating Keras model objects ---------------------------------------
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(keras)))
suppressWarnings(suppressMessages(library(recipes)))

# Binary classification ---------------------------------------------------
# On IMDB data set
imdb <- dataset_imdb(num_words = 10000)
# Use multiassignment operator from zeallot for compactness
c(c(train_data, train_labels), c(test_data, test_labels)) %<-% imdb
# Encode into binary matrix
vectorize_sequence <- function(sequences, dimension = 10000) {
  results <- matrix(0, nrow = length(sequences), ncol = dimension)
  for (i in 1:length(sequences)) {
    results[i, sequences[[i]]] <- 1
  }
  results
}
# Apply
x_train <- vectorize_sequence(train_data)
x_test <- vectorize_sequence(test_data)
# Convert labels too
y_train <- as.numeric(train_labels)
y_test <- as.numeric(test_labels)
# Model definition
bin_keras <- keras_model_sequential() %>%
  layer_dense(units = 16, activation = "relu", input_shape = c(10000)) %>%
  layer_dense(units = 16, activation = "relu") %>%
  layer_dense(units = 1, activation = "sigmoid")
# Compiling
bin_keras %>% compile(
  optimizer = "rmsprop",
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)
# Validation set
val_indices <- 1:10000
x_val <- x_train[val_indices, ]
partial_x_train <- x_train[-val_indices, ]
y_val <- y_train[val_indices]
partial_y_train <- y_train[-val_indices]
# Monitor
history <- bin_keras %>% fit(
  partial_x_train,
  partial_y_train,
  epochs = 4,
  batch_size = 512,
  validation_data = list(x_val, y_val)
)
# Save testing data
testing_data <- list(x_test = x_test,
                     y_test = y_test)
save(testing_data, file = "inst/extdata/testing_binaryclass_keras.rda")
# Serialize to R object
temp_object <- serialize_model(bin_keras, include_optimizer = TRUE)
save(temp_object, file = "inst/extdata/binaryclass_keras.rda")

# Scalar regression -------------------------------------------------------
# On Boston Housing data set
boston <- dataset_boston_housing()
c(c(train_data, train_labels), c(test_data, test_labels)) %<-% boston
# Create model and fit
reformatted_train <- as.data.frame(train_data) %>%
  bind_cols(y = train_labels)
preprocessed_data <- train_data %>%
  recipe(y ~ ., data = reformatted_train) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  prep(training = reformatted_train) %>%
  bake(new_data = reformatted_train)
reg_keras <- linear_reg() %>%
  set_engine("keras",
             hidden = 2,
             activation = "relu",
             epochs = 20,
             batch_size = 25) %>%
  fit(y ~ ., data = preprocessed_data)
# Save testing data, done this way since `predict` follows from keras object, not parsnip
mean <- apply(train_data, 2, mean)
std <- apply(train_data, 2, sd)
test_data <- scale(test_data, center = mean, scale = std)
testing_data <- list(x_test = test_data,
                     y_test = test_labels)
save(testing_data, file = "inst/extdata/testing_reg_keras.rda")
# Save
temp_object <- serialize_model(reg_keras$fit, include_optimizer = TRUE)
save(temp_object, file = "inst/extdata/reg_keras.rda")

# TODO: include an example not using keras_model_sequential() but the
# functional API, build one with completely arbitrary architecture? The
# model object hopefully shouldn't be that different.
