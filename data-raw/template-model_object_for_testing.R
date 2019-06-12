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
library(lobstr)
library(glmnet)
library(keras)
library(rpart)

# Data --------------------------------------------------------------------
# For classification
data(kyphosis)
set.seed(1234)
split <- initial_split(kyphosis, props = 9/10)
spine_train <- training(split)
spine_test  <- testing(split)
# For regression
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Linear Regression -------------------------------------------------------
car_model <- linear_reg()
# LM ----------------------------------------------------------------------
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
# KERAS -------------------------------------------------------------------
early_stopping <- callback_early_stopping(monitor = 'loss', min_delta = 0.000001)
keras_fit <- car_model_penalized %>%
  set_engine("keras", epochs = 1000, batch_size = 1, callbacks = !!early_stopping) %>%
  fit(mpg ~ ., data = car_train, control = ctrl)
# SPARK -------------------------------------------------------------------
# TODO: Learn how to use spark, create this with spark data obj, make sense of
# spark_fit <- car_model_penalized %>%
#   set_engine("spark")


# Logistic regression -----------------------------------------------------

# GLM ---------------------------------------------------------------------

# GLMNET ------------------------------------------------------------------


# STAN --------------------------------------------------------------------



# Multinomial regression --------------------------------------------------


# GLMNET ------------------------------------------------------------------



# Nearest neighbor --------------------------------------------------------
# There is only one engine currently available with nearest neighbor. kknn


# Random forest -----------------------------------------------------------


# RANDOMFOREST ------------------------------------------------------------


# RANGER ------------------------------------------------------------------



# Survival regression -----------------------------------------------------


# FLEXSURV ----------------------------------------------------------------


# SURVREG -----------------------------------------------------------------




# Decision tree -----------------------------------------------------------
# RPART -------------------------------------------------------------------
# This engine requires the specification of a cost/complexity parameter as
# well as the depth of the tree.
treereg_fit <- decision_tree(mode = "regression",
                            cost_complexity = NULL,
                            tree_depth = 5,
                            min_n = 2) %>%
  set_engine("rpart") %>%
  fit(mpg ~ ., data = car_train)
treeclass_fit <- decision_tree(mode = "classification",
                               cost_complexity = NULL,
                               tree_depth = 5,
                               min_n = NULL) %>%
  set_engine("rpart") %>%
  fit(Kyphosis ~ ., data = spine_train)
# C5.0 --------------------------------------------------------------------
treeC5_fit <- decision_tree(mode = "classification") %>%
  set_engine("C5.0") %>%
  fit(Kyphosis ~ ., data = spine_train)
# Save results ------------------------------------------------------------
usethis::use_data(# LINEAR REGRESSION
                  lm_fit,
                  stan_fit,
                  glmnet_fit,
                  keras_fit,
                  # DECISION TREES
                  treereg_fit,
                  treeclass_fit,
                  treeC5_fit,
                  internal = TRUE,
                  overwrite = TRUE)

# Compare -----------------------------------------------------------------
# load("./R/sysdata.rda")
# lm_os <- butcher::weigh(lm_fit, 0)
# glmnet_os <- butcher::weigh(glmnet_fit, 0)
# stan_os <- butcher::weigh(stan_fit, 0)
# l2_os <- butcher::weigh(l2_fit, 0)

