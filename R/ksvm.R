#' Axing a ksvm object.
#'
#' ksvm objects are created from \pkg{kernlab} package, which provides
#' a means to do classification, regression, clustering, novelty
#' detection, quantile regression and dimensionality reduction.
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

#' Remove the call.
#'
#' @rdname axe-ksvm
#' @export
axe_call.ksvm <- function(x, verbose = FALSE, ...) {
  old <- x
  x@kcall <- call("dummy_call")

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove data.
#'
#' @rdname axe-ksvm
#' @export
axe_data.ksvm <- function(x, verbose = FALSE, ...) {
  old <- x
  x@ymatrix <- numeric(0)

  add_butcher_attributes(
    x,
    old,
    disabled = c("ymatrix()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-ksvm
#' @export
axe_fitted.ksvm <- function(x, verbose = FALSE, ...) {
  old <- x
  x@fitted <- numeric(0)

  add_butcher_attributes(
    x,
    old,
    disabled = c("fitted()"),
    add_class = FALSE,
    verbose = verbose
  )
}

