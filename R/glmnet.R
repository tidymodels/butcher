#' Axing an lm.
#'
#' This is where all the lm specific documentation lies.
#'
#' @name axe-lm
NULL

#' @rdname axe-lm
#' @export
axe.lm <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_lm"
  x
}

#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-lm
#' @export
axe_env.lm <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-lm
#' @export
axe_env.fitted <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-lm
#' @export
predict.butcher_lm <- function(x, ...) {
  class(x) <- "lm"
  predict(x, ...)
}

