#' Axing a train object.
#'
#' This is where all the train specific documentation lies.
#'
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(caret)))
#' suppressWarnings(suppressMessages(library(recipes)))
#' suppressWarnings(suppressMessages(library(dplyr)))
#' suppressWarnings(suppressMessages(library(QSARdata)))
#'
#' # Load data
#' data(AquaticTox)
#' tox <- AquaticTox_moe2D
#' tox$Activity <- AquaticTox_Outcome$Activity # Add the outcome variable
#'
#' # Create an additional helper variable for performance measure
#' tox <- tox %>%
#'   select(-Molecule) %>%
#'   ## Suppose the easy of manufacturability is
#'   ## related to the molecular weight of the compound
#'   mutate(manufacturability  = 1/moe2D_Weight) %>%
#'   mutate(manufacturability = manufacturability/sum(manufacturability))
#'
#' # Helper function to calculate weights based on manufacturability
#' model_stats <- function(data, lev = NULL, model = NULL) {
#'   stats <- defaultSummary(data, lev = lev, model = model)
#'   wt_rmse <- function (pred, obs, wts, na.rm = TRUE)
#'     sqrt(weighted.mean((pred - obs)^2, wts, na.rm = na.rm))
#'   res <- wt_rmse(pred = data$pred,
#'                  obs = data$obs,
#'                  wts = data$manufacturability)
#'   c(wRMSE = res, stats)
#' }
#'
#' # Create a recipe
#' tox_recipe <- recipe(Activity ~ ., data = tox) %>%
#'   add_role(manufacturability, new_role = "performance var") %>%
#'   # Remove zero variance predictors
#'   step_nzv(all_predictors()) %>%
#'   # Retain the components required to capture 95% of info
#'   step_pca(contains("VSA"), prefix = "surf_area_", threshold = .95) %>%
#'   # Avoid having predictor pairs with correlation greater than 90%
#'   step_corr(all_predictors(), -starts_with("surf_area"), threshold = .90) %>%
#'   # Center and scale
#'   step_center(all_predictors()) %>%
#'   step_scale(all_predictors())
#'
#' # Create model and fit
#' set.seed(888)
#' tox_ctrl <- trainControl(method = "cv", summaryFunction = model_stats)
#' train_fit <- train(tox_recipe, tox,
#'                    method = "svmRadial",
#'                    metric = "wRMSE",
#'                    maximize = FALSE,
#'                    tuneLength = 10,
#'                    trControl = tox_ctrl)
#'
#' # Axe
#' axe(train_fit)
#'
#' @name axe-train
NULL

#' Call can be removed without breaking \code{predict}. Additional call
#' parameters are stored under \code{dots} in the model object and can
#' also be removed.
#'
#' @rdname axe-train
#' @export
axe_call.train <- function(x, ...) {
  x$call <- call("dummy_call")
  x$dots <- list(NULL)
  x
}

#' The following controls can be removed without break \code{predict}.
#'
#' @rdname axe-train
#' @export
axe_ctrl.train <- function(x, ...) {
  x$control <- list(NULL)
  x
}

#' The training data used to fit the model can be removed.
#'
#' @rdname axe-train
#' @export
axe_data.train <- function(x, ...) {
  x$trainingData <- data.frame(NA)
  x
}

#' Since the \code{recipes} package relies on quosures, a lot of environments
#' are stored.
#'
#' @rdname axe-train
#' @export
axe_env.train <- function(x, ...) {
  x$recipe <- axe_env(x$recipe, ...)
  x
}

#' Fitted values are removed from train object since it is not called in
#' its \code{predict} function at all.
#'
#' @rdname axe-train
#' @export
axe_fitted.train <- function(x, ...) {
  x$pred <- list(NULL)
  x
}

#' A number of misc components saved from model training can be removed,
#' including the resampling results for the optimal model \code{results},
#' data frame with final parameters \code{bestTune}, summary metric used
#' to select the optimal model \code{metric}, data frame with columns for
#' each performance metric \code{resample}, character vector of performance
#' metrics produced by summary \code{perfNames}, range of the training set
#' outcomes \code{yLimits}, and execution times \code{times}.
#'
#' @rdname axe-train
#' @export
axe_misc.train <- function(x, ...) {
  x$results <- data.frame(NA)
  x$bestTune <- data.frame(NA)
  x$metric <- character(0)
  x$resample <- data.frame(NA)
  x$perfNames <- character(0)
  x$yLimits <- numeric(0)
  x$times <- list(NULL)
  x
}

#' The objects that result from the \code{recipes} package are of the
#' class train.recipe and train. Objects of these classes thus rely on
#' the \code{caret::predict.train.recipe} and \code{caret::predict.train}
#' functions. \code{caret::predict.train.recipe} is a wrapper for
#' \code{caret::rec_pred}, which primarily relies on the \code{modelInfo},
#' \code{finalModel}, and \code{recipe} component of the original train.recipe
#' object. As a result, we can pretty much axe any component outside of these.
#' The \code{caret::predict.train} function is a
#'
#' @rdname axe-train
#' @export
predict.butcher_train.recipe <- function(x, ...) {
  class(x) <- c("train.recipe", "train")
  predict(x, ...)
}

