#' Axe the call.
#'
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
#' @examples
#'
#' axe(lm_fit)
axe <- function(x, ...) {
  UseMethod("axe")
}

#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @param x model object
#'
#' @return model object without call attribute
#' @export
#' @examples
#' axe_call(lm_fit)
axe_call <- function(x, ...) {
  UseMethod("axe_call")
}

#' Axe controls.
#'
#' Remove the controls attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without control tuning parameters for training.
#' @export
#' @examples
#' axe_ctrl(treereg_fit)
axe_ctrl <- function(x, ...) {
  UseMethod("axe_ctrl")
}



#' Axe data.
#'
#' Remove the training data attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the training data
#' @export
#' @examples
#' axe_data(kknn_fit)
axe_data <- function(x, ...) {
  UseMethod("axe_data")
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
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}

#' Axe fitted.
#'
#' Remove the fitted values attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the fitted values
#' @export
#' @examples
#' axe_fitted(kknn_fit)
axe_fitted <- function(x, ...) {
  UseMethod("axe_fitted")
}



#' Axe miscellaneous.
#'
#' Remove the intermediary units attached to modeling objects.
#'
#' @param x model object
#'
#' @return model object without the extra intermediatary units previously stored for training.
#' @export
#' @examples
#' axe_misc(glmnet_multi)
axe_misc <- function(x, ...) {
  UseMethod("axe_misc")
}

