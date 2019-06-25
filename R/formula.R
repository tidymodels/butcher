#' Axing formulas.
#'
#' formulas often wrap environments that carry a lot of unneccesary junk.
#'
#' @param x formula
#' @param ... any additional arguments related to axing
#'
#' @return axed formula
#'
#' @name axe-formula
NULL

#' Remove the environment.
#'
#' @rdname axe-formula
#' @export
axe_env.formula <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}
