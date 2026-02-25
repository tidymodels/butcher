#' Axing a catboost.Model.
#'
#' catboost.Model objects are created from the \pkg{catboost} package.
#' These models store minimal training artifacts but do include
#' pre-computed feature importances that can be removed.
#'
#' @inheritParams butcher
#'
#' @return Axed catboost.Model object.
#'
#' @examplesIf rlang::is_installed(c("catboost", "parsnip", "bonsai"))
#' library(parsnip)
#' library(bonsai)
#'
#' mod <- boost_tree(trees = 10) %>%
#'   set_engine("catboost", verbose = 0) %>%
#'   set_mode("classification") %>%
#'   fit(Species ~ ., data = iris)
#'
#' # Extract the underlying catboost model
#' catboost_model <- mod$fit
#'
#' butchered <- butcher(catboost_model, verbose = TRUE)
#'
#' # Predictions still work
#' mod$fit <- butchered
#' predict(mod, iris)
#'
#' @name axe-catboost.Model
NULL

#' Remove the call.
#'
#' @rdname axe-catboost.Model
#' @export
axe_call.catboost.Model <- function(x, verbose = FALSE, ...) {
  # catboost.Model doesn't store a call object
  add_butcher_attributes(x, x, add_class = FALSE, verbose = verbose)
}

#' Remove controls used for training.
#'
#' @rdname axe-catboost.Model
#' @export
axe_ctrl.catboost.Model <- function(x, verbose = FALSE, ...) {
  # catboost.Model doesn't store training controls
  add_butcher_attributes(x, x, add_class = FALSE, verbose = verbose)
}

#' Remove the training data.
#'
#' @rdname axe-catboost.Model
#' @export
axe_data.catboost.Model <- function(x, verbose = FALSE, ...) {
  # catboost.Model doesn't store training data
  add_butcher_attributes(x, x, add_class = FALSE, verbose = verbose)
}

#' Remove environments.
#'
#' @rdname axe-catboost.Model
#' @export
axe_env.catboost.Model <- function(x, verbose = FALSE, ...) {
  # cpp_obj environment is minimal and required for prediction
  add_butcher_attributes(x, x, add_class = FALSE, verbose = verbose)
}

#' Remove pre-computed feature importances.
#'
#' @rdname axe-catboost.Model
#' @export
axe_fitted.catboost.Model <- function(x, verbose = FALSE, ...) {
  old <- x
  x$feature_importances <- NULL

  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "Pre-computed feature_importances (can be recalculated with catboost.get_feature_importance())"
    ),
    add_class = FALSE,
    verbose = verbose
  )
}
