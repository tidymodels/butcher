#' Axing an survreg.penal
#'
#' survreg.penal objects are created from the \pkg{survival} package. They
#' are returned from the \code{survreg} function, representing fitted
#' parametric survival models. This is where all the survreg.penal specific
#' documentation lies.
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
#' suppressWarnings(suppressMessages(library(survival)))
#'
#' # Create model and fit
#' survreg_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
#'   set_engine("survreg") %>%
#'   fit(Surv(time, status) ~ rx + frailty.gaussian(litter, df = 13), data = rats)
#'
#' butcher(survreg_fit)
#'
#' @name axe-survreg.penal
NULL

#' Remove the call.
#'
#' @rdname axe-survreg.penal
#' @export
axe_call.survreg.penal <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")

  add_butcher_attributes(x, old,
                         disabled = c("print", "summary"),
                         verbose = verbose)
}

#' Remove the data.
#'
#' @rdname axe-survreg.penal
#' @export
axe_data.survreg.penal <- function(x, verbose = TRUE, ...) {
  old <- x
  x$y <- numeric(0)

  add_butcher_attributes(x, old,
                         disabled = c("residuals"),
                         verbose = verbose)
}

#' Remove environments.
#'
#' @rdname axe-survreg.penal
#' @export
axe_env.survreg.penal <- function(x, verbose = TRUE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}
