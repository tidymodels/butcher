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
  x$model <- purrr::map(x$model, function(z) axe_env(z, ...))
  x$dataset$src$con$state <- rlang::set_env(x$dataset$src$con$state, rlang::empty_env())
  x
}

#' Remove the environments after reloading the model.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_model <- function(x, ...) {
  x$stages <- purrr::map(x$stages, function(z) axe_env(z, ...))
  x
}

#' Remove the environments for a \code{ml_r_formula_model}.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_r_formula_model <- function(x, ...) {
  if(!is.null(x$.jobj)) {
    x$.jobj <- NULL
  }
  x
}

#' Remove the environments for a \code{ml_index_to_string}.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_index_to_string <- function(x, ...) {
  if(!is.null(x$.jobj)) {
    x$.jobj <- NULL
  }
  x
}

#' Remove the environments for a \code{ml_decision_tree_classification_model}.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_decision_tree_classification_model <- function(x, ...) {
  if(!is.null(x$.jobj)) {
    x$.jobj <- NULL
  }
  if(!is.null(x$feature_importances)) {
    x$feature_importances <- rlang::set_env(x$feature_importances, rlang::empty_env())
  }
  if(!is.null(x$num_nodes)) {
    x$num_nodes <- rlang::set_env(x$num_nodes, rlang::empty_env())
  }
  if(!is.null(x$depth)) {
    x$depth <- rlang::set_env(x$depth, rlang::empty_env())
  }
  x
}

#' Remove the environments associated with pipeline steps.
#'
#' @rdname axe-spark
#' @export
axe_env.ml_pipeline_stage <- function(x, ...) {
  if(!is.null(x$.jobj)) {
    x$.jobj <- NULL
  }
  if(!is.null(x$feature_importances)) {
    x$feature_importances <- rlang::set_env(x$feature_importances, rlang::empty_env())
  }
  if(!is.null(x$num_nodes)) {
    x$num_nodes <- rlang::set_env(x$num_nodes, rlang::empty_env())
  }
  if(!is.null(x$depth)) {
    x$depth <- rlang::set_env(x$depth, rlang::empty_env())
  }
  x
}

#' Remove the pipeline. Often the associated model pipeline is
#' serialized such that the saved model has both the data processing
#' information as well as the model fit information saved.
#'
#' @rdname axe-spark
#' @export
axe_misc.ml_model <- function(x, ...) {
  x$pipeline <- list(NULL)
  x
}


