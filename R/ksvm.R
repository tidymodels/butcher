#' Axing a ksvm object.
#'
#' This is where all the ksvm specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(kernlab)))
#'
#' # Load data
#' data(spam)
#'
#' # Create model and fit
#' ksvm_class <- svm_poly(mode = "classification") %>%
#'   set_engine("kernlab", kernel = "rbfdot") %>%
#'   fit(type ~ ., data = spam)
#'
#' butcher(ksvm_class)
#'
#' @name axe-ksvm
NULL

