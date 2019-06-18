#' Axe the call.
#'
#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @param x model object
#'
#' @return model object without call attribute
#' @export
#' @examples
#' axe_call(lm_fit)
axe_call <- function(x, ...) {
  UseMethod("axe_call")
}

#' @export
axe_call.default <- function(x, ...) {
  x
}
