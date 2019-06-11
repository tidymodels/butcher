#' Axe an object.
#'
#' Reduce the size of a model object so that it takes up less memory on disk.
#' Currently the model object is stripped down to the point that only the
#' minimal components necessary for the `predict` function to work remain.
#' Future adjustments to this function will be needed to avoid removal of
#' model fit components to ensure it works with other downstream functions.
#'
#' @param x model object
#'
#' @return axed model object
#' @examples
#'
#' axe(lm_fit)
axe <- function(x, ...) {
  UseMethod("axe")
}

axe.default <- function(x, ...) {

}

axe.lm <- function(x, ...) {

}

axe.elnet <- function(x, ...) {

}

axe.model_fit <- function(x, ...) {
  if(!inherits(x, "model_fit")){
    stop("Not a parsnip model object.")
  }
  dots <- rlang::enquos(..., .named = TRUE)
  axe(x$fit, dots)
}



