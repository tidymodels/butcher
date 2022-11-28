#' Axing a mda.
#'
#' mda objects are created from the \pkg{mda} package, leveraged to
#' carry out mixture discriminant analysis.
#'
#' @inheritParams butcher
#'
#' @return Axed mda object.
#'
#' @examplesIf rlang::is_installed("mda")
#' library(mda)
#'
#' fit <- mda(Species ~ ., data = iris)
#' out <- butcher(fit, verbose = TRUE)
#'
#' # Another mda object
#' data(glass)
#' wrapped_mda <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- mda(Type ~ ., data = glass)
#'   return(fit)
#' }
#'
#' lobstr::obj_size(wrapped_mda())
#' lobstr::obj_size(butcher(wrapped_mda()))
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
