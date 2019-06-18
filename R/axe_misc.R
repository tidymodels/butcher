#' Axe miscellaneous.
#'
#' Remove the intermediary units attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the extra intermediatary units previously stored for training.
#' @export
#' @examples
#' axe_misc(glmnet_multi)
axe_misc <- function(x, ...) {
  UseMethod("axe_misc")
}

