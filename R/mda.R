#' Axing a mda.
#'
#' mda objects are created from \pkg{mda} package, which is used for
#' mixture discriminant analysis. This is where all the mda specific
#' documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#' @examples
#' library(mda)
#' fit <- mda(Species ~ ., data = iris)
#'
#' butcher(fit)
#' @name axe-mda
NULL

#' Remove the call.
#'
#' @rdname axe-mda
#' @export
axe_call.mda <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()", "update()"),
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-mda
#' @export
axe_env.mda <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-mda
#' @export
axe_fitted.mda <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- exchange(x$fit, "fitted.values", matrix(NA))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
