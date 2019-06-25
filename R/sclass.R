#' Axing a sclass object.
#'
#' sclass objects are byproducts of classbagg objects. Since there are
#' axe functions specific to this class, we keep all documentation
#' related to sclass objects here.
#'
#' @param x sclass object
#' @param ... any additional arguments related to axing
#'
#' @return axed sclass object
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
#' butcher(classbagg_fit$mtrees[[1]])
#' @name axe-sclass
NULL

#' Remove the call. Each subtree is a rpart object.
#'
#' @rdname axe-sclass
#' @export
axe_call.sclass <- function(x, ...) {
  x$btree <- axe_call(x$btree, ...)
  x
}

#' Remove the environment. Each subtree is a rpart object.
#'
#' @rdname axe-sclass
#' @export
axe_env.sclass <- function(x, ...) {
  x$btree <- axe_env(x$btree, ...)
  x
}