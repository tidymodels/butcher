#' Axing a mda.
#'
#' mda and fda objects are created from the \pkg{mda} package, leveraged to
#' carry out mixture discriminant analysis and flexible discriminat analysis,
#' respectively.
#'
#' @inheritParams butcher
#'
#' @return Axed mda object.
#'
#' @examplesIf rlang::is_installed("mda")
#' library(mda)
#'
#' mtcars$cyl <- as.factor(mtcars$cyl)
#'
#' fit <- mda(cyl ~ ., data = mtcars)
#' out <- butcher(fit, verbose = TRUE)
#'
#' fit2 <- fda(cyl ~ ., data = mtcars)
#' out2 <- butcher(fit2, verbose = TRUE)
#'
#' # Another mda object
#' data(glass)
#' wrapped_mda <- function(fit_fn) {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- fit_fn(Type ~ ., data = glass)
#'   return(fit)
#' }
#'
#' lobstr::obj_size(wrapped_mda(mda))
#' lobstr::obj_size(butcher(wrapped_mda(mda)))
#'
#' lobstr::obj_size(wrapped_mda(fda))
#' lobstr::obj_size(butcher(wrapped_mda(fda)))
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

#' @rdname axe-mda
#' @export
axe_call.fda <- axe_call.mda

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

#' @rdname axe-mda
#' @export
axe_env.fda <- axe_env.mda

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

#' @rdname axe-mda
#' @export
axe_fitted.fda <- axe_fitted.mda
