#' Axing a classbagg object.
#'
#' classbagg objects are created from the \pkg{ipred} package, which
#' leverages various resampling and bagging techniques to improve
#' predictive models.
#'
#' @inheritParams butcher
#'
#' @return Axed classbagg object.
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
#' out <- butcher(classbagg_fit, verbose = TRUE)
#'
#' # Fit another model
#' data("DLBCL", package = "ipred")
#'
#' mod <- bagging(Gene.Expression ~ MGEc.1 + MGEc.2 + MGEc.3 + MGEc.4 + IPI,
#'                data = DLBCL,
#'                coob = TRUE)
#'
#' out <- butcher(mod, verbose = TRUE)
#'
#' @name axe-classbagg
NULL

#' Remove the call. Calls located within each subtree is also removed.
#'
#' @rdname axe-classbagg
#' @export
axe_call.classbagg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))
  x$mtrees <- purrr::map(x$mtrees, function(z) axe_call(z, ...))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove training data. There are also responses stored as either a factor
#' vector of class labels, a vector of numerical values, or an object of class
#' \code{Surv} that can also be removed from \code{x$y} for consistency.
#'
#' @rdname axe-classbagg
#' @export
axe_data.classbagg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "X", data.frame(NA))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-classbagg
#' @export
axe_env.classbagg <- function(x, verbose = FALSE, ...) {
  old <- x
  x$mtrees <- purrr::map(x$mtrees, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
