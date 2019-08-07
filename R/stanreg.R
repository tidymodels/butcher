#' Axing a stanreg.
#'
#' stanreg objects are created from the \pkg{rstanarm} package, leveraged
#' to do Bayesian regression modeling with \pkg{stan}.
#'
#' @inheritParams butcher
#'
#' @return Axed stanreg object.
#'
#' @examples
#' \donttest{
#' library(rstanarm)
#' fit <- stan_glm(mpg ~ wt, data = mtcars, algorithm = "optimizing")
#' butcher(fit)
#' }
#' @name axe-stanreg
NULL

#' Remove the call.
#'
#' @rdname axe-stanreg
#' @export
axe_call.stanreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-stanreg
#' @export
axe_env.stanreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x$stanfit@.MISC <- rlang::empty_env()
  x$stanfit@stanmodel@dso@.CXXDSOMISC <- rlang::empty_env()
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-stanreg
#' @export
axe_fitted.stanreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
