#' Axing a C5.0.
#'
#' C5.0 objects are created from the \code{C50} package, which provides an
#' interface to the C5.0 classification model. The models that can be
#' generated include basic tree-based models as well as rule-based models.
#' This is where all the C5.0 specific documentation lies.
#'
#' @name axe-C5.0
NULL

#' As the call is the heaviest part of C5.0 objects, it is replaced with a
#' placeholder. This is done without breaking \code{predict}.
#'
#' @rdname axe-C5.0
#' @export
axe_call.C5.0 <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' The control parameters can be axed without affecting \code{predict}.
#'
#' @rdname axe-C5.0
#' @export
axe_ctrl.C5.0 <- function(x, ...) {
  x$control <- list(NULL)
  x
}

#' A number of misc components saved from training can be removed, including
#' the string version of the command line output, the parsed version of the
#' boosting table(s) \code{boostResults}, and copies of the model argument
#' \code{costMatrix}.
#'
#' @rdname axe-C5.0
#' @export
axe_misc.C5.0 <- function(x, ...) {
  x$output <- character(0)
  x$boostResults <- list(NULL)
  x$costMatrix <- list(NULL)
  x
}

#' @rdname axe-C5.0
#' @export
predict.butcher_C5.0 <- function(x, ...) {
  class(x) <- "C5.0"
  predict(x, ...)
}
