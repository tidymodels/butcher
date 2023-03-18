#' Axing a nested_model_fit.
#'
#' nested_model_fit objects are created from the \pkg{nestedmodels}
#' package, which allows parsnip models to be fitted on nested data. Axing a
#' nested_model_fit object involves axing all the inner model_fit objects.
#'
#' @inheritParams butcher
#'
#' @seealso [axe-model_fit]
#'
#' @return Axed nested_model_fit object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "nestedmodels"))
#'
#' library(nestedmodels)
#' library(parsnip)
#'
#' model <- linear_reg() %>%
#'   set_engine("lm") %>%
#'   nested()
#'
#' nested_data <- tidyr::nest(example_nested_data, data = -id)
#'
#' fit <- fit(model, z ~ x + y + a + b, nested_data)
#'
#' # Reduce the model size
#' butcher(fit)
#'
#' @name axe-nested_model_fit
NULL

#' Remove the call.
#'
#' @rdname axe-nested_model_fit
#' @export
axe_call.nested_model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$.model_fit <- purrr::map(
    x$fit$.model_fit,
    axe_call,
    verbose = FALSE,
    ...
  )

  disabled <- attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  add_butcher_attributes(x, old, disabled = disabled, verbose = verbose)
}

#' Remove controls used for training.
#'
#' @rdname axe-nested_model_fit
#' @export
axe_ctrl.nested_model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$.model_fit <- purrr::map(
    x$fit$.model_fit,
    axe_ctrl,
    verbose = FALSE,
    ...
  )

  disabled <- attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  add_butcher_attributes(x, old, disabled = disabled, verbose = verbose)
}

#' Remove the training data.
#'
#' @rdname axe-nested_model_fit
#' @export
axe_data.nested_model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$.model_fit <- purrr::map(
    x$fit$.model_fit,
    axe_data,
    verbose = FALSE,
    ...
  )

  disabled <- attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  add_butcher_attributes(x, old, disabled = disabled, verbose = verbose)
}

#' Remove environments.
#'
#' @rdname axe-nested_model_fit
#' @export
axe_env.nested_model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$.model_fit <- purrr::map(
    x$fit$.model_fit,
    axe_env,
    verbose = FALSE,
    ...
  )

  disabled <- attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  add_butcher_attributes(x, old, disabled = disabled, verbose = verbose)
}

#' Remove fitted values.
#'
#' @rdname axe-nested_model_fit
#' @export
axe_fitted.nested_model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$.model_fit <- purrr::map(
    x$fit$.model_fit,
    axe_fitted,
    verbose = FALSE,
    ...
  )

  disabled <- attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  add_butcher_attributes(x, old, disabled = disabled, verbose = verbose)
}
