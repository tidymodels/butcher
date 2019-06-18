#' Axing an multnet.
#'
#' This is where all the multnet specific documentation lies.
#'
#' @name axe-multnet
NULL

#' @rdname axe-multnet
#' @export
axe.multnet <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_multnet"
  x
}

#' @rdname axe-multnet
#' @export
axe_call.multnet <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-multnet
#' @export
axe_env.multnet <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-multnet
#' @export
axe_fitted.multnet <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-multnet
#' @export
axe_misc.multnet <- function(x, ...) {
  # Remove matrix that tracks the number of nonzero coefficients per class
  x$dfmat <- NULL
  x
}

#' @rdname axe-multnet
#' @export
predict.butcher_multnet <- function(x, ...) {
  class(x) <- "multnet"
  predict(x, ...)
}

