#' Axing an flexsurvreg.
#'
#' flexsurvreg objects are created from the \pkg{flexsurv} package. They
#' differ from survreg in that the fitted models are not limited to certain
#' parametric distributions. Users can define their own distribution, or
#' leverage distributions like the generalized gamma, generalized F, and
#' the Royston-Parmar spline model.
#'
#' @inheritParams butcher
#'
#' @return Axed flexsurvreg object.
#'
#' @examplesIf rlang::is_installed("flexsurv")
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(flexsurv)))
#'
#' # Create model and fit
#' flexsurvreg_fit <- surv_reg(mode = "regression", dist = "gengamma") %>%
#'   set_engine("flexsurv") %>%
#'   fit(Surv(Tstart, Tstop, status) ~ trans, data = bosms3)
#'
#' out <- butcher(flexsurvreg_fit, verbose = TRUE)
#'
#' # Another flexsurvreg model object
#' wrapped_flexsurvreg <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- flexsurvreg(Surv(futime, fustat) ~ 1,
#'                      data = ovarian, dist = "weibull")
#'   return(fit)
#' }
#'
#' out <- butcher(wrapped_flexsurvreg(), verbose = TRUE)
#' @name axe-flexsurvreg
NULL

#' Remove the call.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_call.flexsurvreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()"),
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_env.flexsurvreg <- function(x, verbose = FALSE, ...) {
  old <- x
  attributes(x$data$m)$terms <- axe_env(attributes(x$data$m)$terms)
  attributes(x$concat.formula)$`.Environment` <- rlang::base_env()
  x$all.formulae <- purrr::map(x$all.formulae, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
