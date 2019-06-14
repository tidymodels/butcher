#' Wrapper for predict.
#'
#' Since all the axed model objects are assigned to some butcher_ class, in order
#' for these smaller objects to work downstream with post-training functions
#' like `predict`, we need to reassign it to its old class.
#'
#' @param x axed model object
#'
#' @return output from correct predict function
#' @export
predict <- function(x, ...) {
  UseMethod("predict")
}

#' @export
predict.butcher_lm <- function(x, ...) {
  class(x) <- "lm"
  predict(x, ...)
}


