#' Axing an survreg.
#'
#' survreg objects are created from the \pkg{survival} package. They
#' are returned from the \code{survreg} function, representing fitted
#' parametric survival models.
#'
#' @inheritParams butcher
#'
#' @return Axed survreg object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "survival"))
#' # Load libraries
#' library(parsnip)
#' library(survival)
#'
#' # Create model and fit
#' survreg_fit <- survival_reg(dist = "weibull") |>
#'   set_engine("survival") |>
#'   fit(Surv(futime, fustat) ~ 1, data = ovarian)
#'
#' out <- butcher(survreg_fit, verbose = TRUE)
#'
#' # Another survreg object
#' wrapped_survreg <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- survreg(Surv(time, status) ~ ph.ecog + age + strata(sex),
#'                  data = lung)
#'   return(fit)
#' }
#'
#' # Remove junk
#' cleaned_survreg <- butcher(wrapped_survreg(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_survreg)
#'
#' @name axe-survreg
NULL

#' Remove the call.
#'
#' @rdname axe-survreg
#' @export
axe_call.survreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove the data.
#'
#' @rdname axe-survreg
#' @export
axe_data.survreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "y", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("residuals()"),
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-survreg
#' @export
axe_env.survreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
