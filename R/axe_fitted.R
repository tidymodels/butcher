#' Axe fitted.
#'
#' Remove the fitted values attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the fitted values
#' @export
#' @examples
#' axe_fitted(kknn_fit)
axe_fitted <- function(x, ...) {
  UseMethod("axe_fitted")
}

