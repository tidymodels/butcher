#' Axing an survreg.
#'
#' survreg objects are created from the \pkg{survival} package. They
#' are returned from the \code{survreg} function, representing fitted
#' parametric survival models. This is where all the survreg specific
#' documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
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
#'   set_engine("survival") %>%
#'   fit(Surv(futime, fustat) ~ 1, data = ovarian)
#'
#' butcher(survreg_fit)
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
