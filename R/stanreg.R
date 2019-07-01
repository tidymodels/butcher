#' Axing a stanreg.
#'
#' This is where all the stanreg specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-stanreg
NULL

#' Remove the call.
#'
#' @rdname axe-stanreg
#' @export
axe_call.stanreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' Remove environments.
#'
#' @rdname axe-stanreg
#' @export
axe_env.stanreg <- function(x, ...) {
  x$stanfit@.MISC <- rlang::empty_env()
  x$stanfit@stanmodel@dso@.CXXDSOMISC <- rlang::empty_env()
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' Remove fitted values.
#'
#' @rdname axe-stanreg
#' @export
axe_fitted.stanreg <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}


