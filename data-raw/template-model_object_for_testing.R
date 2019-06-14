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
suppressMessages(library(parsnip))
suppressMessages(library(tidymodels))
library(lobstr)
suppressMessages(library(glmnet))
suppressMessages(library(keras))
suppressMessages(library(rpart))
suppressMessages(library(flexsurv))

# Data --------------------------------------------------------------------
# For classification
set.seed(1234)
split <- initial_split(kyphosis, props = 9/10)
spine_train <- training(split)
spine_test  <- testing(split)
# For linear regression
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)
# For multinomial regression
predictrs <- matrix(rnorm(100*20), ncol = 20)
response <- as.factor(sample(1:4, 100, replace = TRUE))
# For survival
data(ovarian)

# Linear Regression -------------------------------------------------------
car_model <- linear_reg()
# LM ----------------------------------------------------------------------
lm_fit <- car_model %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = car_train)
# STAN --------------------------------------------------------------------
# Don't print stan output
ctrl <- fit_control(verbosity = 0)
stan_fit <- car_model %>%
  set_engine("stan") %>%
  fit(mpg ~ ., data = car_train, control = ctrl)
# GLMNET ------------------------------------------------------------------
car_model_penalized <- linear_reg(mixture = 0, penalty = 0.1)
glmnet_fit <- car_model_penalized %>%
  set_engine("glmnet") %>%
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
multi_model <- multinom_reg()
# GLMNET ------------------------------------------------------------------
glmnet_multi <- multi_model %>%
  set_engine("glmnet") %>%
  fit_xy(x = predictrs, y = response)
# KERAS -------------------------------------------------------------------
keras_multi <- multi_model %>%
  set_engine("keras", epochs = 10, batch_size = 1, callbacks = !!early_stopping) %>%
  fit_xy(x = predictrs, y = response, control = ctrl)

# Nearest neighbor --------------------------------------------------------
# There is only one engine currently available with nearest neighbor.
kknn_fit <- nearest_neighbor(mode = "classification",
                             neighbors = 3,
                             weight_func = "gaussian",
                             dist_power = 2) %>%
  set_engine("kknn") %>%
  fit(Kyphosis ~ ., data = spine_train)

# Random forest -----------------------------------------------------------
rf_model <- rand_forest(mode = "classification", mtry = 2, trees = 2, min_n = 3)
# RANDOMFOREST ------------------------------------------------------------
rf_fit <- rf_model %>%
  set_engine("randomForest") %>%
  fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)
# RANGER ------------------------------------------------------------------
ranger_fit <- rf_model %>%
  set_engine("ranger") %>%
  fit(Kyphosis ~ ., data = spine_train)

# Survival regression -----------------------------------------------------
surv_model <- surv_reg(mode = "regression", dist = "weibull")
# FLEXSURV ----------------------------------------------------------------
flex_fit <- surv_model %>%
  set_engine("flexsurv") %>%
  fit(Surv(futime, fustat) ~ 1, data = ovarian)
# SURVREG -----------------------------------------------------------------
surv_fit <- surv_model %>%
  set_engine("survreg") %>%
  fit(Surv(futime, fustat) ~ 1, data = ovarian)

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
                  # MULTINOM REGRESSION
                  glmnet_multi,
                  keras_multi,
                  # NEAREST NEIGHBOR
                  kknn_fit,
                  # RANDOM FOREST
                  rf_fit,
                  ranger_fit,
                  # SURVIVAL
                  flex_fit,
                  surv_fit,
                  # DECISION TREES
                  treereg_fit,
                  treeclass_fit,
                  treeC5_fit,
                  internal = TRUE,
                  overwrite = TRUE)

# Notes to self -----------------------------------------------------------
# FLEXSURVREG TESTING
# x <- flexsurvreg(Surv(Tstart, Tstop, status) ~ trans,
#                     data=bosms3, dist="exp")
# tmat <- rbind(c(NA,1,2),c(NA,NA,3),c(NA,NA,NA))
# pmatrix.fs(x, t=c(5,10), trans=tmat)
# totlos.fs(x, t=10, trans=tmat)
# should also work with `bootci.fmsm`

# Compare -----------------------------------------------------------------
# load("./R/sysdata.rda")
# lm_os <- butcher::weigh(lm_fit, 0)
# glmnet_os <- butcher::weigh(glmnet_fit, 0)
# stan_os <- butcher::weigh(stan_fit, 0)
# l2_os <- butcher::weigh(l2_fit, 0)

