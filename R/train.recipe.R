#' Axing a train.recipe object.
#'
#' train.recipe objects are slightly different from train objects
#' created from the \code{caret} package in that it also includes
#' instructions from a \code{recipe} for data pre-processing. Axing
#' functions specific to train.recipe are thus included as additional
#' steps are required to remove the fat attached to train.recipe objects.
#'
#' @param x train.recipe object
#' @param ... any additional arguments related to axing
#'
#' @return axed train.recipe object
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
#'   # Retrain the components required to capture 95% of info
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
#' train.recipe_fit <- train(tox_recipe, tox,
#'                    method = "svmRadial",
#'                    metric = "wRMSE",
#'                    maximize = FALSE,
#'                    tuneLength = 10,
#'                    trControl = tox_ctrl)
#'
#' out <- butcher(train.recipe_fit)
#'
#' @name axe-train.recipe
NULL

#' Remove the call. Additional call parameters are stored under
#' \code{dots} in the model object and should also be removed for
#' consistency.
#'
#' @rdname axe-train.recipe
#' @export
axe_call.train.recipe <- function(x, ...) {
  x$call <- call("dummy_call")
  x$dots <- list(NULL)
  add_butcher_class(x)
}

#' Remove controls. For a train.recipe object, an environment is
#' stored under \code{attr(attributes(x$control$summaryFunction)$srcref, "srcfile")}
#' and thus will also be removed.
#'
#' @rdname axe-train.recipe
#' @export
axe_ctrl.train.recipe <- function(x, ...) {
  x$control <- list(NULL)
  add_butcher_class(x)
}

#' Remove training data.
#'
#' @rdname axe-train.recipe
#' @export
axe_data.train.recipe <- function(x, ...) {
  x$trainingData <- data.frame(NA)
  add_butcher_class(x)
}

#' Remove environments. Model objects of this type include references to
#' environments in each step of the recipe, and thus must also be
#' removed. Note that environments that result from \code{srcref} are
#' not axed.
#'
#' @rdname axe-train.recipe
#' @export
axe_env.train.recipe <- function(x, ...) {
  x$recipe <- axe_env(x$recipe, ...)
  x$modelInfo <- purrr::map(x$modelInfo, function(z) axe_env(z, ...))
  add_butcher_class(x)
}

#' Remove fitted values stored in \code{pred}. Outcome values are numeric
#' for regression and character for classification. If the model object
#' was created under classification, there is a second argument level that
#' stores the outcome factor levels and could also removed for consistency.
#'
#' @rdname axe-train.recipe
#' @export
axe_fitted.train.recipe <- function(x, ...) {
  x$pred <- list(NULL)
  add_butcher_class(x)
}
