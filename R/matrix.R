#' Axing matrices.
#'
#' matrices often store a lot of intermediary training material that is unnecessary
#' in downstream data analysis functions.
#'
#' @param x matrix or matrices
#' @param ... any additional arguments related to axing
#'
#' @return axed matrix
#'
#' @name axe-matrix
NULL

#' Remove the matrix.
#'
#' @rdname axe-matrix
#' @export
axe_misc.matrix <- function(x, ...) {
  x <- matrix(NA)
  add_butcher_class(x)
}
