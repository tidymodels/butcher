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


