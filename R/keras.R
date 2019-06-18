#' Axing an keras.
#'
#' This is where all the keras specific documentation lies.
#'
#' @name axe-keras
NULL

#' @rdname axe-keras
#' @export
axe.keras <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_keras"
  x
}

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

#' @rdname axe-keras
#' @export
predict.butcher_keras <- function(x, ...) {
  class(x) <- "keras"
  predict(x, ...)
}

