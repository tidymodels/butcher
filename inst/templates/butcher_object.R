#' Axing {{article}} {{model_class}}.
#'
#' @inheritParams butcher
#'
#' @return Axed {{model_class}} object.
#'
#' @examples
#' ##
#' ## Insert examples to create and axe model object here...
#' ##
#' @name axe-{{model_class}}
NULL

#' Remove the call.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_call.{{model_class}} <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-{{model_class}}
#' @export
axe_ctrl.{{model_class}} <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-{{model_class}}
#' @export
axe_data.{{model_class}} <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-{{model_class}}
#' @export
axe_env.{{model_class}} <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-{{model_class}}
#' @export
axe_fitted.{{model_class}} <- function(x, verbose = FALSE, ...) {
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
