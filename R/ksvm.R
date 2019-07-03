#' Axing a ksvm object.
#'
#' This is where all the ksvm specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
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

