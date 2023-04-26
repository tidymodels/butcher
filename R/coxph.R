#' Axing a coxph.
#'
#' @inheritParams butcher
#'
#' @return Axed coxph object.
#'
#' @details
#' The [survival::coxph()] model is unique in how it uses environments in
#' its components, and butchering such an object can behave in surprising ways
#' in any environment other than the
#' [global environment](https://adv-r.hadley.nz/environments.html#important-environments)
#' (such as when wrapped in a function). We do not recommend that you use
#'  `butcher()` with a `coxph` object anywhere other than the global environment.
#'
#'  Do this:
#'
#' ```r
#' my_coxph_func <- function(df) {
#'     coxph(Surv(time, status) ~ x + strata(covar), df)
#' }
#' ## in global environment only:
#' butcher(my_coxph_func(df))
#' ```
#'
#' Do *not* do this:
#'
#' ```r
#' my_coxph_func <- function(df) {
#'     res <- coxph(Surv(time, status) ~ x + strata(covar), df)
#'     ## no:
#'     butcher(res)
#' }
#'
#' ## will not work correctly:
#' my_coxph_func(df)
#' ```
#'
#' @examplesIf rlang::is_installed("survival")
#' library(survival)
#'
#' example_data <-
#'   tibble::tibble(
#'     time = rpois(1000, 2) + 1,
#'     status = rbinom(1000, 1, .5),
#'     x = rpois(1000, .5),
#'     covar = rbinom(1000, 1, .5)
#'   )
#'
#' example_data
#'
#' make_big_model <- function() {
#'   boop <- runif(1e6)
#'   coxph(Surv(time, status) ~ x + strata(covar), example_data)
#' }
#'
#' res <- make_big_model()
#'
#' weigh(res)
#' weigh(butcher(res))
#'
#' @name axe-coxph
NULL

#' @rdname axe-coxph
#' @export
axe_env.coxph <- function(x, verbose = FALSE, ...) {
  res <- x
  res$formula <- axe_env(res$formula, verbose = verbose, ...)

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-coxph
#' @export
axe_data.coxph <- function(x, verbose = FALSE, ...) {
  res <- x
  res <- exchange(res, "y", numeric(0))

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}
