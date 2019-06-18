#' Axing an flexsurvreg.
#'
#' This is where all the flexsurvreg specific documentation lies.
#'
#' @name axe-flexsurvreg
NULL

#' @rdname axe-flexsurvreg
#' @export
axe.flexsurvreg <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_flexsurvreg"
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_call.flexsurvreg <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_ctrl.flexsurvreg <- function(x, ...) {
  # Details around initial distribution
  x$dlist$inits <- NULL
  x$mx <- NULL
  x$npars <- NULL
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_data.flexsurvreg <- function(x, ...) {
  x$data$Y <- NULL
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_env.flexsurvreg <- function(x, ...) {
  attributes(x$data$m)$terms <- axe_env(attributes(x$data$m)$terms)
  attributes(x$concat.formula)$`.Environment` <- rlang::empty_env()
  attributes(x$all.formulae$rate)$`.Environment` <- rlang::empty_env()
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_fitted.flexsurvreg <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-flexsurvreg
#' @export
axe_misc.flexsurvreg <- function(x, ...) {
  x$AIC <- NULL
  x$datameans <- NULL
  x$N <- NULL
  x$events <- NULL
  x$trisk <- NULL
  x$concat.formula <- NULL
  x$basepars <- NULL
  x$fixedpars <- NULL
  x$optpars <- NULL
  x$loglik <- NULL
  x$logliki <- NULL
  x$opt <- NULL
  x
}

#' @rdname axe-flexsurvreg
#' @export
predict.butcher_flexsurvreg <- function(x, ...) {
  class(x) <- "flexsurvreg"
  predict(x, ...)
}

