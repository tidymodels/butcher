#' Axe the call.
#'
#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @param x model object
#'
#' @return model object without call attribute
#' @export
#' @examples
#' axe_call(lm_fit)
axe_call <- function(x, ...) {
  UseMethod("axe_call")
}

#' @export
axe_call.default <- function(x, ...) {
  x
}

#' @export
axe_call.lm <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}


#' @export
axe_call.glm <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @export
axe_call.glmnet <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @export
axe_call.elnet <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @export
axe_call.stanreg <- function(x, ...) {
  axe_call.default(x, ...)
}

#' @export
axe_env.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_call.default(x, ...)
}

#' @export
axe_env.keras.engine.training.Model <- function(x, ...) {
  axe_call.default(x, ...)
}


#' @export
axe_call.rpart <- function(x, ...) {
  x$call <- call("dummy_call")
  # Calls also located in `function`
  x$functions <- call("dummy_call")
  x
}

#' @export
axe_call.C5.0 <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @export
axe_call.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_call(x$fit, ...)
}
