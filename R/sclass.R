#' Axing a sclass object.
#'
#' sclass objects are byproducts of classbagg objects. Since there are
#' axe functions specific to this class, there is where all documentation
#' related to sclass objects lies.
#'
#' @param x sclass object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed sclass object.
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
axe_call.sclass <- function(x, verbose = FALSE, ...) {
  old <- x
  x$btree <- axe_call(x$btree, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}

#' Remove the environment. Each subtree is a rpart object.
#'
#' @rdname axe-sclass
#' @export
axe_env.sclass <- function(x, verbose = FALSE, ...) {
  old <- x
  x$btree <- axe_env(x$btree, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}
