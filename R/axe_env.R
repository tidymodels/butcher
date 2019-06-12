#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are often
#' not required in the downstream analysis pipeline. Currently, if found,
#' the environment is completely removed. In future iterations, we might
#' want to consider replacing the environment object with a NULL.
#'
#' @param x model object
#'
#' @return model object without environment attribut
#' @export
#' @examples
#' axe_env(lm_fit)
axe_env <- function(x, ...) {
  UseMethod("axe_env")
}

#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- NULL
  x
}

#' @export
axe_env.data.frame <- function(x, ...) {
  attr(x, ".Environment") <- NULL
  x
}

#' @export
axe_env.lm <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  return(x)
}

#' @export
axe_env.glmnet <- function(x, ...) {
  # No environment stored
  x
}

#' @export
axe_env.elnet <- function(x, ...) {
  # No environment stored
  x
}

#' @export
axe_env.stanreg <- function(x, ...) {
  # TODO: check differences between glm and stanreg objects
  # Replace the `.MISC` slot with an empty env
  x$stanfit@.MISC <- rlang::empty_env()
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  return(x)
}

#' @export
axe_env.glm <- function(x, ...) {
  axe_env(x, ...)
}

#' @export
axe_env.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_env(x$fit, ...)
}
