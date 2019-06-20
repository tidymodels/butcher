#' Axing an lm.
#'
#' This is where all the lm specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Make a lm that has a lot of extra stuff in its environment
#' make_an_lm <- function() {
#'   x <- rep(1L, times = 10e6)
#'   lm(1 ~ 1)
#' }
#' lm_object <- make_an_lm()
#' lm_axed <- axe(lm_object)
#'
#' @name axe-lm
NULL

#' Call can be removed without breaking \code{predict}. Currently, the
#' \code{predict} only relies on the \code{offset} feature stored in the
#' call which is rarely used.
#'
#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' The same environment is referenced in terms as well as model attribute.
#' Both need to be addressed in order for the environment to be completely
#' replaced with an empty environment.
#'
#' @rdname axe-lm
#' @export
axe_env.lm <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' Fitted values are removed from lm object since it is not called in
#' its \code{predict} function at all.
#'
#' @rdname axe-lm
#' @export
axe_fitted.lm <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-lm
#' @export
predict.butcher_lm <- function(x, ...) {
  class(x) <- "lm"
  predict(x, ...)
}

