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
axe_ctrl.randomFoest <- function(x, ...) {
  # Number of trees grown
  x$ntree <- NULL
  # Number of predictors sampled
  x$mtry <- NULL
  x
}

#' @export
axe_ctrl.ranger <- function(x, ...) {
  # Number of variables to split at each node
  x$mtry <- NULL
  # Min node size
  x$min.node.size <- NULL
  # Splitting rule
  x$splitrule <- NULL
  # Sample with replacement
  x$replace <- NULL
  # Number of samples
  x$num.samples <- NULL
  x
}

#' @export
axe_ctrl.flexsurvreg <- function(x, ...) {
  # Details around initial distribution
  x$dlist$inits <- NULL
  x$mx <- NULL
  x$npars <- NULL
  x
}

#' @export
axe_ctrl.survreg <- function(x, ...) {
  # TODO: dig
  axe_ctrl.default(x, ...)
}

#' @export
axe_ctrl.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_ctrl(x$fit, ...)
}
