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
#' @return axed model object with new butcher subclass assignment
#' @export
#' @examples
#'
#' axe(lm_fit)
axe <- function(x, ...) {
  UseMethod("axe")
}

#' @export
axe.default <- function(x, ...) {
  class(x) <- "butcher"
  x
}


#' @export
axe.glm <- function(x, ...) {
  class(x) <- "butcher_glm"
  x
}

#' @export
axe.glmnet <- function(x, ...) {
  class(x) <- "butcher_glmnet"
  x
}

#' @export
axe.elnet <- function(x, ...) {
  class(x) <- "butcher_elnet"
  x
}

#' @export
axe_env.keras.engine.sequential.Sequential <- function(x, ...) {
  class(x) <- "butcher_keras"
  x
}

#' @export
axe.C5.0 <- function(x, ...) {
  class(x) <- "butcher_c5"
  x
}

#' @export
axe.multnet <- function(x, ...) {
  class(x) <- "butcher_multnet"
  x
}

#' @export
axe.model_fit <- function(x, ...) {
  if(!inherits(x, "model_fit")){
    stop("Not a parsnip model object.")
  }
  axe(x$fit, ...)
}
