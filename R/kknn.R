#' Axing an kknn.
#'
#' kknn objects are created from the \code{kknn} package, which is utilized to
#' do weighted k-Nearest Neighbors for classification, regression and clustering.
#' This is where all the kknn specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#' suppressWarnings(suppressMessages(library(rpart)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, props = 9/10)
#' spine_train <- training(split)
#' spine_test  <- testing(split)
#'
#' # Create model and fit
#' kknn_fit <- nearest_neighbor(mode = "classification",
#'                              neighbors = 3,
#'                              weight_func = "gaussian",
#'                              dist_power = 2) %>%
#'   set_engine("kknn") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' butcher(kknn_fit)
#'
#' @name axe-kknn
NULL

#' Remove the call.
#'
#' @rdname axe-kknn
#' @export
axe_call.kknn <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' Remove the environment.
#'
#' @rdname axe-kknn
#' @export
axe_env.kknn <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  x
}

#' Remove fitted values.
#'
#' @rdname axe-kknn
#' @export
axe_fitted.kknn <- function(x, ...) {
  x$fitted.values <- list(NULL)
  x
}
