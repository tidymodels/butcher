#' Axe an object.
#'
#' Reduce the size of a model object so that it takes up less memory on disk.
#' Currently the model object is stripped down to the point that only the
#' minimal components necessary for the `predict` function to work remain.
#' Future adjustments to this function will be needed to avoid removal of
#' model fit components to ensure it works with other downstream functions.
#'
#' @param x model object
#'
#' @return axed model object with new butcher subclass assignment
#' @export
axe <- function(x, ...) {
  x <- axe_call(x, ...)
  x <- axe_ctrl(x, ...)
  x <- axe_data(x, ...)
  x <- axe_env(x, ...)
  x <- axe_fitted(x, ...)
  x <- axe_misc(x, ...)
  # Get original class
  og_class <- class(x)[1]
  # TODO: insert check here
  class(x) <- paste0("butcher_", og_class)
  x
}


#' Axe a call.
#'
#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @param x model object
#'
#' @return model object without call attribute
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_call")}
#'
#' @export
#' @examples
#' axe_call(lm_fit)
axe_call <- function(x, ...) {
  UseMethod("axe_call")
}

#' @export
axe_call.default <- function(x, ...) {
  x
}

#' Axe controls.
#'
#' Remove the controls from training attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without control tuning parameters from training
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_ctrl")}
#'
#' @export
axe_ctrl <- function(x, ...) {
  UseMethod("axe_ctrl")
}

#' @export
axe_ctrl.default <- function(x, ...) {
  x
}

#' Axe data.
#'
#' Remove the training data attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the training data
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_data")}
#'
#' @export
axe_data <- function(x, ...) {
  UseMethod("axe_data")
}

#' @export
axe_data.default <- function(x, ...) {
  x
}

#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are often
#' not required in the downstream analysis pipeline. Currently, if found,
#' the environment is replaced with rlang::empty_env.
#'
#' @param x model object
#' @param ... other arguments passed to axe methods
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_env")}
#'
#' @export
axe_env <- function(x, ...) {
  UseMethod("axe_env")
}

#' @export
axe_env.default <- function(x, ...) {
  x
}

#' Axe fitted values.
#'
#' Remove the fitted values attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the fitted values
#' @export
axe_fitted <- function(x, ...) {
  UseMethod("axe_fitted")
}

#' @export
axe_fitted.default <- function(x, ...) {
  x
}

#' Axe miscellaneous.
#'
#' Remove the intermediary steps attached from training to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the extra intermediatary units previously stored for training.
#' @export
axe_misc <- function(x, ...) {
  UseMethod("axe_misc")
}

#' @export
axe_misc.default <- function(x, ...) {
  x
}

