#' Axing a ksvm object.
#'
#' ksvm objects are created from \pkg{kernlab} package, which provides
#' a means to do classification, regression, clustering, novelty
#' detection, quantile regression and dimensionality reduction. Since
#' fitted model objects from \pkg{kernlab} are S4, the \code{butcher_ksvm}
#' class is not appended.
#'
#' @inheritParams butcher
#'
#' @return Axed ksvm object.
#'
#' @examples
#' \donttest{
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(kernlab)))
#'
#' # Load data
#' data(spam)
#'
#' # Create model and fit
#' ksvm_class <- svm_poly(mode = "classification") %>%
#'   set_engine("kernlab") %>%
#'   fit(type ~ ., data = spam)
#'
#' out <- butcher(ksvm_class, verbose = TRUE)
#' }
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

