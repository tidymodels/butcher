#' Axing an model_fit.
#'
#' This is where all the model_fit specific documentation lies.
#'
#' @name axe-model_fit
NULL

#' @rdname axe-model_fit
#' @export
axe.model_fit <- function(x, ...) {
  if(!inherits(x, "model_fit")){
    stop("Not a parsnip model object.")
  }
  axe(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_call.model_fit <- function(x, ...) {
  axe_call(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_ctrl.model_fit <- function(x, ...) {
  axe_ctrl(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_data.model_fit <- function(x, ...) {
  axe_data(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_env.model_fit <- function(x, ...) {
  axe_env(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_fitted.model_fit <- function(x, ...) {
  axe_fitted(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
axe_misc.model_fit <- function(x, ...) {
  axe_misc(x$fit, ...)
}

#' @rdname axe-model_fit
#' @export
predict.butcher_model_fit <- function(x, ...) {
  class(x) <- "model_fit"
  predict(x, ...)
}

