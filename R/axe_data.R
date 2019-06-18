#' Axe data.
#'
#' Remove the training data attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the training data
#' @export
#' @examples
#' axe_data(kknn_fit)
axe_data <- function(x, ...) {
  UseMethod("axe_data")
}

