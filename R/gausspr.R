#' Axing a gausspr.
#'
#' gausspr objects are created from \pkg{kernlab} package, which
#' provides a means to do classification, regression, clustering,
#' novelty detection, quantile regression and dimensionality
#' reduction. Since fitted model objects from \pkg{kernlab} are S4,
#' the \code{butcher_gausspr} class is not appended.
#'
#' @inheritParams butcher
#'
#' @return Axed gausspr object.
#'
#' @examplesIf rlang::is_installed("kernlab")
#' library(kernlab)
#'
#' test <- gausspr(Species ~ ., data = iris, var = 2)
#'
#' out <- butcher(test, verbose = TRUE)
#'
#' # Example with simulated regression data
#' x <- seq(-20, 20, 0.1)
#' y <- sin(x)/x + rnorm(401, sd = 0.03)
#' test2 <- gausspr(x, y)
#' out <- butcher(test2, verbose = TRUE)
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
