#' Axing a tabnet_fit.
#'
#' @inheritParams butcher
#'
#' @return Axed tabnet_fit object.
#'
#' @examples
#' ##
#' ## Insert examples to create and axe model object here...
#' ##
#' @name axe-tabnet_fit
NULL

#' Remove the call.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_call.tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove controls used for training.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_ctrl.tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", "???")

  add_butcher_attributes(
    x,
    old,
    disabled = c("some_function()", "another_function()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove the training data.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_data.tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "data", "???")

  add_butcher_attributes(
    x,
    old,
    disabled = c("some_function()", "another_function()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_env.tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    disabled = c("some_function()", "another_function()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_fitted.tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", "???")

  add_butcher_attributes(
    x,
    old,
    disabled = c("some_function()", "another_function()"),
    add_class = FALSE,
    verbose = verbose
  )
}
