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
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_env")}
#'
#' @export
axe_env <- function(x, ...) {
  UseMethod("axe_env")
}

#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}
