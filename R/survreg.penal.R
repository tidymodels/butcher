#' Axing an survreg.penal
#'
#' survreg.penal objects are created from the \pkg{survival} package. They
#' are returned from the \code{survreg} function, representing fitted
#' parametric survival models.
#'
#' @inheritParams butcher
#'
#' @return Axed survreg object.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(survival)))
#' suppressWarnings(library(lobstr))
#'
#' # Create model and fit
#' survreg_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
#'   set_engine("survival") %>%
#'   fit(Surv(time, status) ~ rx, data = rats)
#'
#' out <- butcher(survreg_fit, verbose = TRUE)
#'
#' # Another survreg.penal object
#' wrapped_survreg.penal <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- survreg(Surv(time, status) ~ rx,
#'                  data = rats, subset = (sex == "f"))
#'   return(fit)
#' }
#'
#' # Remove junk
#' cleaned_sp <- axe_env(wrapped_survreg.penal(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_sp)
#'
#' @name axe-survreg.penal
NULL

#' Remove the call.
#'
#' @rdname axe-survreg.penal
#' @export
axe_call.survreg.penal <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-survreg.penal
#' @export
axe_data.survreg.penal <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-survreg.penal
#' @export
axe_env.survreg.penal <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
