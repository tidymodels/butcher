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

#' @export
axe_misc.default <- function(x, ...) {
  # Assuming no misc
  x
}

#' @export
axe_misc.multnet <- function(x, ...) {
  # Remove matrix that tracks the number of nonzero coefficients per class
  x$dfmat <- NULL
  x
}

#' @export
axe_misc.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_misc(x$fit, ...)
}
