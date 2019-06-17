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

#' @export
axe_data.default <- function(x, ...) {
  # Assuming no controls
  x
}


#' @export
axe_data.flexsurvreg <- function(x, ...) {
  x$data$Y <- NULL
  x
}


#' @export
axe_data.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_data(x$fit, ...)
}
