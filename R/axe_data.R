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
axe_data.lm <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.glm <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.glmnet <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.elnet <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.stanreg <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.keras.engine.training.Model <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.rpart <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.C5.0 <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.multnet <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.train.kknn <- function(x, ...) {
  NextMethod("axe_data")
}

#' @export
axe_data.kknn <- function(x, ...) {
  # Stores all the original data to retrain in `predict`
  axe_data.default(x, ...)
}

#' @export
axe_data.randomForest <- function(x, ...) {
  axe_data.default(x, ...)
}

#' @export
axe_data.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_data(x$fit, ...)
}
