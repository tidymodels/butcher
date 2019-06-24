#' Axing an keras.
#'
#' This is where all the keras specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-keras
NULL

#' @rdname axe-keras
#' @export
axe_call.keras <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-keras
#' @export
axe_env.keras <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-keras
#' @export
axe_fitted.keras <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}


