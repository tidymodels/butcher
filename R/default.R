#' Axing for default inputs.
#'
#' These default axe functions treat the model object as if
#' nothing needs to be axed.
#'
#' @name axe-default
NULL

#' @rdname axe-default
#' @export
axe.default <- function(x, ...) {
  class(x) <- "butcher"
  x
}

#' @rdname axe-default
#' @export
axe_call.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
axe_ctrl.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
axe_data.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
axe_env.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
axe_fitted.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
axe_misc.default <- function(x, ...) {
  x
}

#' @rdname axe-default
#' @export
predict.butcher_default <- function(x, ...) {
  class(x) <- "default" # TODO: need to figure out assignment
  predict(x, ...)
}

