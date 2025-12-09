#' Butcher an object.
#'
#' Reduce the size of a model object so that it takes up less memory on
#' disk. Currently, the model object is stripped down to the point that
#' only the minimal components necessary for the \code{predict} function
#' to work remain. Future adjustments to this function will be needed to
#' avoid removal of model fit components to ensure it works with other
#' downstream functions.
#'
#' @param x A model object.
#' @param verbose Print information each time an axe method is executed.
#'  Notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object with new butcher subclass assignment.
#' @export
butcher <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- axe_call(x, verbose = FALSE, ...)
  x <- axe_ctrl(x, verbose = FALSE, ...)
  x <- axe_data(x, verbose = FALSE, ...)
  x <- axe_env(x, verbose = FALSE, ...)
  x <- axe_fitted(x, verbose = FALSE, ...)
  x <- axe_rsample_data(x, verbose = FALSE, ...)
  x <- axe_rsample_indicators(x, verbose = FALSE, ...)

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

#' Axe a call.
#'
#' Replace the call object attached to modeling objects with a placeholder.
#'
#' @inheritParams butcher
#'
#' @return Model object without call attribute.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_call")}
#'
#' @export
axe_call <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_call")
}

#' @export
axe_call.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe controls.
#'
#' Remove the controls from training attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without control tuning parameters from training.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_ctrl")}
#'
#' @export
axe_ctrl <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_ctrl")
}

#' @export
axe_ctrl.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe data.
#'
#' Remove the training data attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without the training data
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_data")}
#'
#' @export
axe_data <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_data")
}

#' @export
axe_data.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are
#' not required in the downstream analysis pipeline. If found,
#' the environment is replaced with \code{rlang::base_env()}.
#'
#' @inheritParams butcher
#'
#' @return Model object with empty environments.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_env")}
#'
#' @export
axe_env <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_env", object = x)
}

#' @export
axe_env.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe fitted values.
#'
#' Remove the fitted values attached to modeling objects.
#'
#' @inheritParams butcher
#'
#' @return Model object without the fitted values.
#'
#' @section Methods:
#' \Sexpr[stage=render,results=rd]{butcher:::methods_rd("axe_fitted")}
#'
#' @export
axe_fitted <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_fitted")
}

#' @export
axe_fitted.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe data within rsample objects.
#'
#' Replace the splitting and resampling objects with a placeholder.
#'
#' Resampling and splitting objects produced by \pkg{rsample} contain `rsplit`
#' objects. These contain the original data set. These data might be large so
#' we sometimes wish to remove them when saving objects. This method creates a
#' zero-row slice of the dataset, retaining only the column names and their
#' attributes, while replacing the original data.
#'
#' @name axe-rsample-data
#' @inheritParams butcher
#' @param x An object.
#'
#' @return An updated object without data in the `rsplit` objects.
#'
#' @section Methods:
#' See the following help topics for more details about individual methods:
#'
#' \code{butcher}
#' \itemize{
#'   \item \code{\link[butcher]{axe-rsample-data}}: \code{default}, \code{rset},
#'   \code{rsplit}, \code{three_way_split}, \code{tune_results},
#'   \code{workflow_set}
#' }
#'
#' @examplesIf rlang::is_installed("rsample")
#'
#' large_cars <- mtcars[rep(1:32, 50), ]
#' large_cars_split <- rsample::initial_split(large_cars)
#' butcher(large_cars_split, verbose = TRUE)
#'
#' @export
axe_rsample_data <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_rsample_data")
}

#' @export
#' @name axe-rsample-data
axe_rsample_data.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' Axe indicators within rsample objects.
#'
#' Replace the splitting and resampling objects with a placeholder.
#'
#' Resampling and splitting objects produced by \pkg{rsample} contain `rsplit`
#' objects. These contain the original data set as well as indicators that
#' specify which rows go into which data partitions. These size of these
#' integers might be large so we sometimes wish to remove them when saving
#' objects. This method saves a zero-row integer in their place.
#'
#' @name axe-rsample-indicators
#' @inheritParams butcher
#' @param x An object.
#'
#' @return An updated object without the indicators in the `rsplit` objects.
#'
#' @section Methods:
#' See the following help topics for more details about individual methods:
#'
#' \code{butcher}
#' \itemize{
#'   \item \code{\link[butcher]{axe-rsample-indicators}}: \code{default},
#'   \code{rset}, \code{rsplit}, \code{three_way_split}, \code{tune_results},
#'   \code{workflow_set}
#' }
#'
#'
#' @examplesIf rlang::is_installed("rsample")
#'
#' large_cars <- mtcars[rep(1:32, 50), ]
#' large_cars_split <- rsample::initial_split(large_cars)
#' butcher(large_cars_split, verbose = TRUE)
#'
#' @export
axe_rsample_indicators <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_rsample_indicators")
}

#' @export
#' @name axe-rsample-indicators
axe_rsample_indicators.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}
