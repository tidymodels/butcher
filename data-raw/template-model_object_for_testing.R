# Depending on the size of the training data and the model engine specified,
# the output of some models require a lot of computational resources to fit.
# This is a template we use to instantiate different model objects for
# testing new functions in this package. After producing the model object of
# interest, we call
#   `usethis::use_data(new_object, internal = TRUE, overwrite = TRUE)`
# to add a new model object to our existing set. All objects created are
# stored in a single `R/sysdata.rda` file. We do this to circumvent the need
# to retrain everytime we want to test a new model object.

# Load --------------------------------------------------------------------
# The models we currently consider are generated from the `parsnip` package.
# However, we would love to add more models objects.
library(parsnip)
library(tidymodels)
library(pryr)
library(glmnet)
library(keras)

# Linear Regression -------------------------------------------------------
# Data
set.seed(1234)
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)
# LM ----------------------------------------------------------------------
# Model
car_model <- linear_reg()
lm_car_model <- car_model %>%
  set_engine("lm")
lm_fit <- lm_car_model %>%
  fit(mpg ~ ., data = car_train)
# STAN --------------------------------------------------------------------
stan_car_model <- car_model %>%
  set_engine("stan")
# Don't print stan output
ctrl <- fit_control(verbosity = 0)
stan_fit <- stan_car_model %>%
  fit(mpg ~ ., data = car_train, control = ctrl)
# GLMNET ------------------------------------------------------------------
car_model_penalized <- linear_reg(mixture = 0, penalty = 0.1)
glmnet_car_model <- car_model_penalized %>%
  set_engine("glmnet")
glmnet_fit <- glmnet_car_model %>%
  fit(mpg ~ ., data = car_train)
# OR.. using glmnet directly.. may want to get rid of this !
car_train_matrix <- car_train %>%
  select(-mpg) %>%
  as.matrix()
# Fit with an L2 penalty
l2_fit <- glmnet(x = car_train_matrix, y = car_train$mpg,
                 alpha = 0, lambda = 0.1)
# KERAS -------------------------------------------------------------------
lr_model <- keras_model_sequential()
lr_model %>%
  layer_dense(units = 1,
              input_shape = dim(car_train_matrix)[2],
              activation = 'linear',
              kernel_regularizer = regularizer_l2(0.1))

early_stopping <- callback_early_stopping(monitor = 'loss', min_delta = 0.000001)

lr_model %>% compile(
  loss = 'mean_squared_error',
  optimizer = optimizer_adam(lr = 0.001)
)

keras_fit <- lr_model %>%
  fit(
    x = car_train_matrix,
    y = car_train$mpg,
    epochs = 1000,
    batch_size = 1,
    callbacks = early_stopping
  )


# Save results ------------------------------------------------------------
usethis::use_data(lm_fit,
                  stan_fit,
                  glmnet_fit,
                  l2_fit,
                  keras_fit,
                  internal = TRUE,
                  overwrite = TRUE)

# Compare -----------------------------------------------------------------
# load("./R/sysdata.rda")
# lm_os <- butcher::weigh(lm_fit, 0)
# glmnet_os <- butcher::weigh(glmnet_fit, 0)
# stan_os <- butcher::weigh(stan_fit, 0)
# l2_os <- butcher::weigh(l2_fit, 0)

