#' Axing an multnet.
#'
#' This is where all the multnet specific documentation lies.
#'
#' Note: Since multnet object is derived from the \code{glmnet} package it is
#' one of the few model objects in which there is no environment to axe.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#'
#' # Load data
#' set.seed(1234)
#' predictrs <- matrix(rnorm(100*20), ncol = 20)
#' response <- as.factor(sample(1:4, 100, replace = TRUE))
#'
#' # Create model and fi
#' multnet_fit <- multinom_reg() %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = predictrs, y = response)
#'
#' butcher(multnet_fit)
#'
#' @name axe-multnet
NULL

#' Remove call.
#'
#' @rdname axe-multnet
#' @export
axe_call.multnet <- function(x, ...) {
  x$call <- call("dummy_call")
  add_butcher_class(x)
}

#' Remove misc. For multnet objects, we remove \code{dfmat}, which
#' tracks the number of nonzero coefficients per class.
#'
#' @rdname axe-multnet
#' @export
axe_misc.multnet <- function(x, ...) {
  x$dfmat <- axe_env(x$dfmat, ...)
  add_butcher_class(x)
}


