#' Axing a mda.
#'
#' mda objects are created from the \pkg{mda} package, leveraged to
#' carry out mixture discriminant analysis.
#'
#' @inheritParams butcher
#'
#' @return Axed mda object.
#'
#' @examples
#' library(mda)
#' fit <- mda(Species ~ ., data = iris)
#' butcher(fit)
#'
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
