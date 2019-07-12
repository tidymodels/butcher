#' Axing a nnet.
#'
#' nnet objects are created from the \pkg{nnet} package.
#' This is where all the nnet specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-nnet
NULL

#' Remove the call.
#'
#' @rdname axe-nnet
#' @export
axe_call.nnet <- function(x, ...) {
  old <- x
  x$call <- call("dummy_call")
  assess_object(old, x, working = c("predict"), broken = ("print"))
  add_butcher_class(x)
}


#' Remove environments.
#'
#' @rdname axe-nnet
#' @export
axe_env.nnet <- function(x, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  assess_object(old, x, working = c("predict"))
  add_butcher_class(x)
}

#' Remove fitted values.
#'
#' @rdname axe-nnet
#' @export
axe_fitted.nnet <- function(x, ...) {
  old <- x
  x$fitted.values <- numeric(0)
  assess_object(old, x, working = c("predict"))
  add_butcher_class(x)
}
