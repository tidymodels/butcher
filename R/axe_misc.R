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
  # Assuming no controls
  x
}


#' @export
axe_misc.lm <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.glm <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.glmnet <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.elnet <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.stanreg <- function(x, ...) {

}

#' @export
axe_misc.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.keras.engine.training.Model <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.rpart <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.C5.0 <- function(x, ...) {
  axe_misc.default(x, ...)
}

#' @export
axe_misc.multnet <- function(x, ...) {
  # Remove matrix that tracks the number of nonzero coefficients per class
  x$dfmat <- NULL
  x
}

#' @export
axe_misc.train.kknn <- function(x, ...) {
  NextMethod("axe_misc")
}

#' @export
axe_misc.kknn <- function(x, ...) {
  # Matrix of misclassification errors
  x$MISCLASS <- NULL
  # Matrix of mean absolute errors
  x$MEAN.ABS <- NULL
  # Matrix of mean squared errors
  x$MEAN.SQU <- NULL
  x
}

#' @export
axe_misc.randomForest <- function(x, ...) {
  # Number of times cases are out-of-bag and used to compute OOB error
  x$oob.times <- NULL
  # (Classification) vector error rates
  x$err.rate <- NULL
  # (Classification) confusion matrix
  x$confusion <- NULL
  # Number of samples inbag
  x$inbag <- NULL
  x
}

#' @export
axe_misc.ranger <- function(x, ...) {
  # Out-of-bag prediction error
  x$prediction.error <- NULL
  x
}

#' @export
axe_misc.flexsurvreg <- function(x, ...) {
  x$AIC <- NULL
  x$datameans <- NULL
  x$N <- NULL
  x$events <- NULL
  x$trisk <- NULL
  x$concat.formula <- NULL
  x$basepars <- NULL
  x$fixedpars <- NULL
  x$optpars <- NULL
  x$loglik <- NULL
  x$logliki <- NULL
  x$opt <- NULL
  x
}

#' @export
axe_misc.survreg <- function(x, ...) {
  # TODO: dig
  axe_misc.default(x, ...)
}

#' @export
axe_misc.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_misc(x$fit, ...)
}
