#' Axing an kknn.
#'
#' This is where all the kknn specific documentation lies.
#'
#' @name axe-kknn
NULL

#' @rdname axe-kknn
#' @export
axe.kknn <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_kknn"
  x
}

#' @rdname axe-kknn
#' @export
axe_call.kknn <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-kknn
#' @export
axe_env.kknn <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  x
}

#' @rdname axe-kknn
#' @export
axe_fitted.kknn <- function(x, ...) {
  x$fitted.values <- NULL
  x
}

#' @rdname axe-kknn
#' @export
axe_misc.kknn <- function(x, ...) {
  # Matrix of misclassification errors
  x$MISCLASS <- NULL
  # Matrix of mean absolute errors
  x$MEAN.ABS <- NULL
  # Matrix of mean squared errors
  x$MEAN.SQU <- NULL
  x
}

#' @rdname axe-kknn
#' @export
predict.butcher_kknn <- function(x, ...) {
  class(x) <- "kknn"
  predict(x, ...)
}

