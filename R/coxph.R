#' Axing a coxph.
#'
#' @inheritParams butcher
#'
#' @return Axed coxph object.
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
