#' Axing an survreg.
#'
#' survreg objects are created from the \code{survival} package. They
#' are returned from the \code{survreg} function, representing fitted
#' parametric survival models. This is where all the survreg specific
#' documentation lies.
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
#' survreg_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
#'   set_engine("survreg") %>%
#'   fit(Surv(futime, fustat) ~ 1, data = ovarian)
#'
#' butcher(survreg_fit)
#'
#' @name axe-survreg
NULL

#' The call can be axed without breaking \code{predict}.
#'
#' @rdname axe-survreg
#' @export
axe_call.survreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' The Surv object can be removed without breaking \code{predict}.
#'
#' @rdname axe-survreg
#' @export
axe_data.survreg <- function(x, ...) {
  x$y <- numeric(0)
  x
}

#' The same environment is referenced in terms as well as model attribute.
#' Both need to be addressed in order for the environment to be completely
#' replaced with an empty environment.
#'
#' @rdname axe-survreg
#' @export
axe_env.survreg <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}


