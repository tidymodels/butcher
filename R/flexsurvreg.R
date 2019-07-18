#' Axing an flexsurvreg.
#'
#' flexsurvreg objects are created from the \pkg{flexsurv} package. They
#' differ from survreg in that the fitted models are not limited to certain
#' parametric distributions. Users can define their own distribution, or
#' leverage distributions like the generalized gamma, generalized F, and
#' the Royston-Parmar spline model. This is where all the flexsurvreg
#' specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(flexsurv)))
#'
#' # Create model and fit
#' flexsurvreg_fit <- surv_reg(mode = "regression", dist = "gengamma") %>%
#'   set_engine("flexsurv") %>%
#'   fit(Surv(Tstart, Tstop, status) ~ trans, data = bosms3)
#'
#' butcher(flexsurvreg_fit)
#'
#' @name axe-flexsurvreg
NULL

#' Remove the call.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_call.flexsurvreg <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print"),
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_env.flexsurvreg <- function(x, verbose = TRUE, ...) {
  old <- x
  attributes(x$data$m)$terms <- axe_env(attributes(x$data$m)$terms)
  attributes(x$concat.formula)$`.Environment` <- rlang::empty_env()
  x$all.formulae <- purrr::map(x$all.formulae, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
