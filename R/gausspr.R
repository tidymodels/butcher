#' Axing a gausspr.
#'
#' gausspr objects are created from \pkg{kernlab} package, which
#' provides a means to do classification, regression, clustering,
#' novelty detection, quantile regression and dimensionality
#' reduction.
#'
#' @inheritParams butcher
#'
#' @return Axed gausspr object.
#'
#' @examples
#' library(kernlab)
#' test <- gausspr(Species ~ ., data = iris, var = 2)
#'
#' butcher(test)
#'
#' @name axe-gausspr
NULL

#' Remove the call.
#'
#' @rdname axe-gausspr
#' @export
axe_call.gausspr <- function(x, verbose = FALSE, ...) {
  old <- x
  x@kcall <- call("dummy_call")

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove the training data.
#'
#' @rdname axe-gausspr
#' @export
axe_data.gausspr <- function(x, verbose = FALSE, ...) {
  old <- x
  x@ymatrix <- NULL

  add_butcher_attributes(
    x,
    old,
    disabled = c("ymatrix()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-gausspr
#' @export
axe_env.gausspr <- function(x, verbose = FALSE, ...) {
  old <- x
  x@terms <- axe_env(x@terms)

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-gausspr
#' @export
axe_fitted.gausspr <- function(x, verbose = FALSE, ...) {
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
