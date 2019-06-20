#' Axing an flexsurvreg.
#'
#' flexsurvreg objects are created from the \code{flexsurv} package. They
#' differ from survreg in that the fitted models are not limited to certain
#' parametric distributions. Users can define their own distribution, or
#' leverage distributions like the generalized gamma, generalized F, and
#' the Royston-Parmar spline model. This is where all the flexsurvreg
#' specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#' suppressWarnings(suppressMessages(library(flexsurv)))
#'
#' # Create model and fit
#' flexsurvreg_fit <- surv_reg(mode = "regression", dist = "gengamma") %>%
#'   set_engine("flexsurv") %>%
#'   fit(Surv(Tstart, Tstop, status) ~ trans, data = bosms3)
#'
#' # Axe
#' axe(flexsurvreg_fit)
#'
#' @name axe-flexsurvreg
NULL

#' The call can be axed.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_call.flexsurvreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' A number of control parameters can be axed.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_ctrl.flexsurvreg <- function(x, ...) {
  # x$dlist$inits # TODO: check whether replacement is worth it
  x$mx <- list(NULL)
  x$npars <- numeric(0)
  x
}

#' One part of the data object can be axed.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_data.flexsurvreg <- function(x, ...) {
  x$data$Y <- numeric(0)
  x
}

#' The same environment is referenced in terms as well as other parts of
#' the flexsurv fitted model. They all need to be addressed in order for
#' the environment to be completely replaced with a base environment.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_env.flexsurvreg <- function(x, ...) {
  attributes(x$data$m)$terms <- axe_env(attributes(x$data$m)$terms)
  attributes(x$concat.formula)$`.Environment` <- rlang::base_env()
  attributes(x$all.formulae$mu)$`.Environment` <- rlang::base_env()
  x
}

#' A number of components stored from training can be removed.
#'
#' @rdname axe-flexsurvreg
#' @export
axe_misc.flexsurvreg <- function(x, ...) {
  x$AIC <- numeric(0)
  x$datameans <- numeric(0)
  x$N <- numeric(0)
  x$events <- numeric(0)
  x$trisk <- numeric(0)
  x$basepars <- numeric(0)
  x$fixedpars <- numeric(0)
  x$optpars <- numeric(0)
  x$loglik <- numeric(0)
  x$logliki <- numeric(0)
  x$opt <- list(NULL)
  x
}

#' @rdname axe-flexsurvreg
#' @export
predict.butcher_flexsurvreg <- function(x, ...) {
  class(x) <- "flexsurvreg" # TODO: this needs to change for flexsurv
  predict(x, ...)
}

