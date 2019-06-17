#' Axing an lm.
#'
#' This is where all the lm specific documentation lies.
#'
#' @name axe-lm
NULL


#' @export
axe_env.lm <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}


#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, ...) {

}

