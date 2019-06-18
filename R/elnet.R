#' Axing an elnet.
#'
#' This is where all the elnet specific documentation lies.
#'
#' @name axe-elnet
NULL

#' @rdname axe-elnet
#' @export
axe.elnet <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_elnet"
  x
}

#' @rdname axe-elnet
#' @export
axe_call.elnet <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-elnet
#' @export
axe_env.elnet <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-elnet
#' @export
axe_fitted.elnet <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-elnet
#' @export
predict.butcher_elnet <- function(x, ...) {
  class(x) <- "elnet"
  predict(x, ...)
}
