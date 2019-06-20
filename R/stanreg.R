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

#' @rdname axe-stanreg
#' @export
axe.stanreg <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_stanreg"
  x
}

#' @rdname axe-stanreg
#' @export
axe_call.stanreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @export
axe_env.stanreg <- function(x, ...) {
  # TODO: check differences between glm and stanreg objects
  # Replace the `.MISC` slot with an empty env
  x$stanfit@.MISC <- rlang::base_env()
  x$stanfit@stanmodel@dso@.CXXDSOMISC <- rlang::base_env()
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-stanreg
#' @export
axe_fitted.stanreg <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-stanreg
#' @export
predict.butcher_stanreg <- function(x, ...) {
  class(x) <- c("stanreg", "glm", "lm")
  predict(x, ...)
}

