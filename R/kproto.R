#' Axing a kproto.
#'
#' @inheritParams butcher
#'
#' @return Axed kproto object.
#'
#' @examplesIf rlang::is_installed("clustMixType")
#' library(clustMixType)
#'
#' kproto_fit <- kproto(
#'   ToothGrowth,
#'   k = 2,
#'   lambda = lambdaest(ToothGrowth),
#'   verbose = FALSE
#' )
#'
#' out <- butcher(kproto_fit, verbose = TRUE)
#'
#' @name axe-kproto
NULL

#' @rdname axe-kproto
#' @export
axe_data.kproto <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "data", data.frame(NA))
  # none of the validation methods in validation_kproto() work if the data is
  # not stored within the model object
  add_butcher_attributes(
    x,
    old,
    disabled = c("validation_kproto()", "summary()"),
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-kproto
#' @export
axe_fitted.kproto <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "cluster", integer(0))
  x <- exchange(x, "dists", matrix(NA_real_))

  add_butcher_attributes(
    x,
    old,
    disabled = c("clprofiles()", "validation_kproto()"),
    add_class = TRUE,
    verbose = verbose
  )
}
