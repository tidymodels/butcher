#' Axing {{article}} {{model_class}}.
#'
#' This is where all the {{model_class}} specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-{{model_class}}
NULL

#' Remove the call.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_call.{{model_class}} <- function(x, ...) {
  add_butcher_class(x)
}

#' Remove controls used for training.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_ctrl.{{model_class}} <- function(x, ...) {
  add_butcher_class(x)
}

#' Remove the training data.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_data.{{model_class}} <- function(x, ...) {
  add_butcher_class(x)
}

#' Remove environments.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_env.{{model_class}} <- function(x, ...) {
  add_butcher_class(x)
}

#' Remove fitted values.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_fitted.{{model_class}} <- function(x, ...) {
  add_butcher_class(x)
}
