#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are often
#' not required in the downstream analysis pipeline. Currently, if found,
#' the environment is replaced with rlang::empty_env.
#'
#' @param x model object
#' @param ... other arguments passed to axe methods
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{generics:::methods_rd("axe_env")}
#'
#' @export
axe_env <- function(x, ...) {
  UseMethod("axe_env")
}

#' @export
axe_env.default <- function(x, ...) {
  # No environment to replace
  x
}

#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}

#' @export
axe_env.data.frame <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}

#' @export
axe_env.kknn <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  x
}

#' @export
axe_env.survreg <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @export
axe_env.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_env(x$fit, ...)
}
