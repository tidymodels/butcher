#' Axing a classbagg object.
#'
#' @param x classbagg object
#' @param ... any additional arguments related to axing
#'
#' @return axed classbagg object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(ipred)))
#' suppressWarnings(suppressMessages(library(rpart)))
#' suppressWarnings(suppressMessages(library(MASS)))
#'
#' # Load data
#' data("GlaucomaM", package = "TH.data")
#'
#' classbagg_fit <- bagging(Class ~ ., data = GlaucomaM, coob = TRUE)
#'
#' butcher(classbagg_fit)
#' @name axe-classbagg
NULL

#' Remove the call. Calls located within each subtree is also removed.
#'
#' @rdname axe-classbagg
#' @export
axe_call.classbagg <- function(x, ...) {
  x$call <- call("dummy_call")
  x$mtrees <- purrr::map(x$mtrees, function(z) axe_call(z, ...))
  x
}

#' Remove training data. There are also responses stored as either a factor
#' vector of class labels, a vector of numerical values, or an object of class
#' \code{Surv} that can also be removed from \code{x$y} for consistency.
#'
#' @rdname axe-classbagg
#' @export
axe_data.classbagg <- function(x, ...) {
  x$X <- data.frame(NA)
  x
}

#' Remove environments. Model objects of this type include references to
#' environments in each step of the recipe, and thus must also be
#' removed. Note that environments that result from \code{srcref} are
#' not axed.
#'
#' @rdname axe-classbagg
#' @export
axe_env.classbagg <- function(x, ...) {
  x$mtrees <- purrr::map(x$mtrees, function(z) axe_env(z, ...))
  x
}
