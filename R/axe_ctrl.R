#' Axe controls.
#'
#' Remove the controls attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without control tuning parameters for training.
#' @export
#' @examples
#' axe_ctrl(treereg_fit)
axe_ctrl <- function(x, ...) {
  UseMethod("axe_ctrl")
}

#' @export
axe_ctrl.default <- function(x, ...) {
  # Assuming no controls
  x
}

