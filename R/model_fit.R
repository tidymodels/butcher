#' Axing an model_fit.
#'
#' model_fit objects are created from the \code{parsnip} package.
#' This is where all the model_fit specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @name axe-model_fit
NULL

#' @rdname axe-model_fit
#' @export
axe_call.model_fit <- function(x, verbose = FALSE, ...) {
  axe_call(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_ctrl.model_fit <- function(x, verbose = FALSE, ...) {
  axe_ctrl(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_data.model_fit <- function(x, verbose = FALSE, ...) {
  axe_data(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_env.model_fit <- function(x, verbose = FALSE, ...) {
  axe_env(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_fitted.model_fit <- function(x, verbose = FALSE, ...) {
  axe_fitted(x$fit, verbose = verbose, ...)
}


