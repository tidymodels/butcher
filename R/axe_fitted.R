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

#' @export
axe_fitted.default <- function(x, ...) {
  # Assuming no fitted values
  x
}


#' @export
axe_fitted.lm <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.glm <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.glmnet <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.elnet <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.stanreg <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.keras.engine.training.Model <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.rpart <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.C5.0 <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.multnet <- function(x, ...) {
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.train.kknn <- function(x, ...) {
  NextMethod("axe_fitted")
}

#' @export
axe_fitted.kknn <- function(x, ...) {
  x$fitted.values <- NULL
}

#' @export
axe_fitted.randomForest <- function(x, ...) {
  # Saved under x$predicted, required if `predict` is called without new data
  axe_fitted.default(x, ...)
}

#' @export
axe_fitted.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_fitted(x$fit, ...)
}
