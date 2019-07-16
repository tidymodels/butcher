#' Axing {{article}} {{model_class}}.
#'
#' This is where all the {{model_class}} specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
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
axe_call.{{model_class}} <- function(x, verbose = TRUE, ...) {
  old <- x
  ##
  ## Insert replacements here...
  ##
  add_butcher_attributes(x, old,
                         disabled = c("???", "???"),
                         verbose = verbose)
}

#' Remove controls used for training.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_ctrl.{{model_class}} <- function(x, verbose = TRUE, ...) {
  old <- x
  ##
  ## Insert replacements here...
  ##
  add_butcher_attributes(x, old,
                         disabled = c("???", "???"),
                         verbose = verbose)
}

#' Remove the training data.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_data.{{model_class}} <- function(x, verbose = TRUE, ...) {
  old <- x
  ##
  ## Insert replacements here...
  ##
  add_butcher_attributes(x, old,
                         disabled = c("???", "???"),
                         verbose = verbose)
}

#' Remove environments.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_env.{{model_class}} <- function(x, verbose = TRUE, ...) {
  old <- x
  ##
  ## Insert replacements here...
  ##
  add_butcher_attributes(x, old,
                         disabled = c("???", "???"),
                         verbose = verbose)
}

#' Remove fitted values.
#'
#' @rdname axe-{{model_class}}
#' @export
axe_fitted.{{model_class}} <- function(x, verbose = TRUE, ...) {
  old <- x
  ##
  ## Insert replacements here...
  ##
  add_butcher_attributes(x, old,
                         disabled = c("???", "???"),
                         verbose = verbose)
}
