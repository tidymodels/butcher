#' Axing an ranger.
#'
#' ranger objects are created from the \code{ranger} package, which is used as
#' a means to quickly train random forests. The package supports ensembles
#' of classification, regression, survival and probability prediction trees.
#' This is where all the ranger specific documentation lies.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(iris, props = 9/10)
#' iris_train <- training(split)
#'
#' # Create model and fit
#' ranger_fit <- rand_forest(mode = "classification",
#'                           mtry = 2,
#'                           trees = 20,
#'                           min_n = 3) %>%
#'   set_engine("ranger") %>%
#'   fit(Species ~ ., data = iris_train)
#'
#' # Axe
#' axe(ranger_fit)
#' @name axe-ranger
NULL

#' The call can be removed without breaking \code{predict}.
#'
#' @rdname axe-ranger
#' @export
axe_call.ranger <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' A number of control parameters used for fitting the ranger object
#' are stored, but unnecessary for \code{predict}. This includes the
#' number of variables to split at each node \code{mtry}, the minimum
#' node size \code{min.node.size}, the splitting rule \code{splitrule},
#' and whether to sample with replacement \code{replace}.
#'
#' @rdname axe-ranger
#' @export
axe_ctrl.ranger <- function(x, ...) {
  x$mtry <- numeric(0)
  x$min.node.size <- numeric(0)
  x$splitrule <- character(0)
  x$replace <- logical(0)
  x
}

#' The fitted ranger object stores fitted values, but in its \code{predict}
#' function, these stored values are not accessed at all.
#'
#' @rdname axe-ranger
#' @export
axe_fitted.ranger <- function(x, ...) {
  x$predictions <- numeric(0)
  x
}

#' The out-of-bag prediction error is stored during training but not
#' necessary for \code{predict.ranger}.
#'
#' @rdname axe-ranger
#' @export
axe_misc.ranger <- function(x, ...) {
  x$prediction.error <- numeric(0)
  x
}

#' @rdname axe-ranger
#' @export
predict.butcher_ranger <- function(x, ...) {
  class(x) <- "ranger"
  predict(x, ...)
}

