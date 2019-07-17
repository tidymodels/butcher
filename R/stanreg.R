#' Axing a stanreg.
#'
#' This is where all the stanreg specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @name axe-stanreg
NULL

#' Remove the call.
#'
#' @rdname axe-stanreg
#' @export
axe_call.stanreg <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")

  add_butcher_attributes(x, old,
                         verbose = verbose)
}

#' Remove environments.
#'
#' @rdname axe-stanreg
#' @export
axe_env.stanreg <- function(x, verbose = TRUE, ...) {
  old <- x
  x$stanfit@.MISC <- rlang::empty_env()
  x$stanfit@stanmodel@dso@.CXXDSOMISC <- rlang::empty_env()
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}

#' Remove fitted values.
#'
#' @rdname axe-stanreg
#' @export
axe_fitted.stanreg <- function(x, verbose = TRUE, ...) {
  old <- x
  x$fitted.values <- numeric(0)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}


