#' Axing a gam.
#'
#' gam objects are created from the \pkg{mgcv} package.
#'
#' @inheritParams butcher
#'
#' @return Axed gam object.
#'
#' @examplesIf rlang::is_installed("mgcv")
#'
#' cars_gam <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
#' cleaned_gam <- butcher(cars_gam, verbose = TRUE)
#'
#' @name axe-gam
NULL

#' Remove the call.
#'
#' @rdname axe-gam
#' @export
axe_call.gam <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = TRUE,
    verbose = verbose
  )
}

#' Remove controls.
#'
#' @rdname axe-gam
#' @export
axe_ctrl.gam <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", list())

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the training data.
#'
#' @rdname axe-gam
#' @export
axe_data.gam <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "model", data.frame(NA))
  x <- exchange(x, "y", numeric(0))
  x <- exchange(x, "weights", numeric(0))
  x <- exchange(x, "prior.weights", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the environments.
#'
#' @rdname axe-gam
#' @export
axe_env.gam <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  x$pterms <- axe_env(x$pterms, ...)
  x$formula <- axe_env(x$formula, ...)
  x$pred.formula <- axe_env(x$pred.formula, ...)
  x$family$variance <- axe_env(x$family$variance, ...)
  x$family$dev.resids <- axe_env(x$family$dev.resids, ...)
  x$family$aic <- axe_env(x$family$aic, ...)
  x$family$validmu <- axe_env(x$family$validmu, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-gam
#' @export
axe_fitted.gam <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))
  x <- exchange(x, "residuals", numeric(0))
  x <- exchange(x, "linear.predictors", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("fitted()", "summary()", "residuals()"),
    verbose = verbose
  )
}
