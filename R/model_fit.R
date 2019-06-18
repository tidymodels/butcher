#' Axing an model_fit.
#'
#' This is where all the model_fit specific documentation lies.
#'
#' @name axe-model_fit
NULL

#' @rdname axe-model_fit
#' @export
axe.model_fit <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_model_fit"
  x
}

#' @rdname axe-model_fit
#' @export
axe_call.model_fit <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-model_fit
#' @export
axe_env.model_fit <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-model_fit
#' @export
axe_fitted.model_fit <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-model_fit
#' @export
predict.butcher_model_fit <- function(x, ...) {
  class(x) <- "model_fit"
  predict(x, ...)
}

