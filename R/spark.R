#' Axing a spark object.
#'
#' spark objects are created from the \pkg{sparklyr} package,
#' a \R interface for Apache Spark. The axe methods available
#' for spark objects are designed such that interoperability
#' is maintained. In other words, for a multilingual machine
#' learning team, butchered spark objects instantiated from
#' \pkg{sparklyr} can still be serialized to disk, work in
#' Python, be deployed on Scala, etc. It is also worth noting
#' here that spark objects created from \pkg{sparklyr} have a
#' lot of metadata attached to it, including but not limited
#' to the formula, dataset, model, index labels, etc. The
#' axe functions provided are for parsing down the model
#' object both prior saving to disk, or loading from disk.
#' Traditional \R save functions are not available for these
#' objects, so functionality is provided in \code{sparklyr::ml_save}.
#' This function gives the user the option to keep either the
#' \code{pipeline_model} or the \code{pipeline}, so both of these
#' objects are retained from butchering, yet removal of one or the
#' other might be conducive to freeing up memory on disk.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @name axe-spark
NULL

#' Remove the call.
#'
#' @rdname axe-spark
#' @export
axe_call.ml_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "formula", "")

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the controls.
#'
#' @rdname axe-spark
#' @export
axe_ctrl.ml_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "label_col", "")
  x <- exchange(x, "features_col", "")
  x <- exchange(x, "feature_names", "")
  x <- exchange(x, "response", "")
  x <- exchange(x, "index_labels", "")

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the data.
#'
#' @rdname axe-spark
#' @export
axe_data.ml_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "dataset", NULL)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x$pipeline_model <- axe_env(x$pipeline_model, ...)
  x$pipeline <- axe_env(x$pipeline, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-spark
#' @export
axe_fitted.ml_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "coefficients", matrix(NA))
  x <- exchange(x, "model", NULL)
  x <- exchange(x, "summary", NULL)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove possible environments from the \code{pipeline_model} object.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_model <- function(x, verbose = TRUE, ...) {
  old <- x
  x$stages <- purrr::map(x$stages, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove possible environments from the \code{pipeline} object.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline <- function(x, verbose = TRUE, ...) {
  old <- x
  x$stages <- purrr::map(x$stages, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove possible environments associated with each pipeline stage.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_stage <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- purrr::map(x, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the bytecode associated with functions in each pipeline step.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_summary<- function(x, verbose = TRUE, ...) {
  old <- x
  x <- purrr::map(x, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

