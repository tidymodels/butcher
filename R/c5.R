#' Axing an C5.0.
#'
#' This is where all the C5.0 specific documentation lies.
#'
#' @name axe-C5.0
NULL

#' @rdname axe-C5.0
#' @export
axe.C5.0 <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_C5.0"
  x
}

#' @rdname axe-C5.0
#' @export
axe_call.C5.0 <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-C5.0
#' @export
axe_ctrl.C5.0 <- function(x, ...) {
  x$control <- NULL
  x
}

#' @rdname axe-C5.0
#' @export
axe_env.C5.0 <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-C5.0
#' @export
axe_fitted.C5.0 <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-C5.0
#' @export
predict.butcher_C5.0 <- function(x, ...) {
  class(x) <- "C5.0"
  predict(x, ...)
}

