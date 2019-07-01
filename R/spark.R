#' Axing a spark object.
#'
#' spark objects are created from the \code{sparklyr} package,
#' a \code{R} interface for Apache Spark. This is where all the
#' spark specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-spark
NULL

#' Remove the environments.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_model <- function(x, ...) {
  x$pipeline_model$stages <- purrr::map(x$pipeline_model$stages, function(z) axe_env(z, ...))
  # x$model <- purrr::map(x$model, function(z) axe_env(z)) # TODO: map without stripping class attributes?
  x$dataset$src$con$state <- rlang::set_env(x$dataset$src$con$state, rlang::empty_env())
  add_butcher_class(x)
}

#' Remove the environments after reloading the model.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_model <- function(x, ...) {
  x$stages <- purrr::map(x$stages, function(z) axe_env(z, ...))
  add_butcher_class(x)
}

#' Remove the environments associated with pipeline steps.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_stage <- function(x, ...) {
  if(!is.null(x$.jobj)) {
    x$.jobj <- NULL
  }
  x <- purrr::map(x, function(z) axe_env(z, ...))
  add_butcher_class(x)
}

#' Remove the pipeline. This is available prior to the user saving the
#' model output using \code{ml_save} or some other \code{save} mechanism.
#' Under these circumstances, the model pipeline is serialized such that
#' the model has both the data processing information as well as the model
#' fit information. For most data post-processing tasks, the content saved
#' in the \code{pipeline} object is not required.
#'
#' @rdname axe-spark
#' @export
axe_misc.ml_model <- function(x, ...) {
  x$pipeline <- list(NULL)
  add_butcher_class(x)
}


