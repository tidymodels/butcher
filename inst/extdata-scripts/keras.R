# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(keras)))

# Load data
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Create model and fit
early_stopping <- callback_early_stopping(monitor = 'loss', min_delta = 0.000001)
ctrl <- fit_control(verbosity = 0)
keras_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
  set_engine("keras", epochs = 1000, batch_size = 1, callbacks = !!early_stopping) %>%
  fit(mpg ~ ., data = car_train, control = ctrl)

# Save
save(keras_fit, file = "inst/extdata/keras.rda")
