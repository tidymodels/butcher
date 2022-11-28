#' Axing a sclass object.
#'
#' sclass objects are byproducts of classbagg objects.
#'
#' @inheritParams butcher
#'
#' @return Axed sclass object.
#'
#' @examplesIf rlang::is_installed(c("ipred", "rpart", "MASS", "TH.data"))
#' # Load libraries
#' library(ipred)
#' library(rpart)
#' library(MASS)
#'
#' # Load data
#' data("GlaucomaM", package = "TH.data")
#'
#' classbagg_fit <- bagging(Class ~ ., data = GlaucomaM, coob = TRUE)
#'
#' out <- butcher(classbagg_fit$mtrees[[1]], verbose = TRUE)
#'
#' # Another classbagg object
#' wrapped_classbagg <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- bagging(Species ~ .,
#'                  data = iris,
#'                  nbagg = 10,
#'                  coob = TRUE)
#'   return(fit)
#' }
#'
#' # Remove junk
#' cleaned_classbagg <- butcher(wrapped_classbagg(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_classbagg)
#'
#' @name axe-sclass
NULL

#' Remove the call. Each subtree is a rpart object.
#'
#' @rdname axe-sclass
#' @export
axe_call.sclass <- function(x, verbose = FALSE, ...) {
  old <- x
  x$btree <- axe_call(x$btree, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the environment. Each subtree is a rpart object.
#'
#' @rdname axe-sclass
#' @export
axe_env.sclass <- function(x, verbose = FALSE, ...) {
  old <- x
  x$btree <- axe_env(x$btree, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
