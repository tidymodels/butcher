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


#' @export
axe_ctrl.lm <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.glm <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.glmnet <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.elnet <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.stanreg <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.keras.engine.training.Model <- function(x, ...) {
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.rpart <- function(x, ...) {
  x$control <- NULL
  x
}

#' @export
axe_ctrl.C5.0 <- function(x, ...) {
  x$control <- NULL
  x
}

#' @export
axe_ctrl.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_ctrl(x$fit, ...)
}
