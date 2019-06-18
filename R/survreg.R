#' Axing an survreg.
#'
#' This is where all the survreg specific documentation lies.
#'
#' @name axe-survreg
NULL

#' @rdname axe-survreg
#' @export
axe.survreg <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_survreg"
  x
}

#' @rdname axe-survreg
#' @export
axe_call.survreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-survreg
#' @export
axe_ctrl.survreg <- function(x, ...) {
  # TODO: revisit
  x
}

#' @rdname axe-survreg
#' @export
axe_data.survreg <- function(x, ...) {
  x$data$Y <- NULL
  x
}

#' @rdname axe-survreg
#' @export
axe_env.survreg <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-survreg
#' @export
axe_fitted.survreg <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-survreg
#' @export
axe_misc.survreg <- function(x, ...) {
  # TODO: dig
  x
}

#' @rdname axe-survreg
#' @export
predict.butcher_survreg <- function(x, ...) {
  class(x) <- "survreg"
  predict(x, ...)
}

