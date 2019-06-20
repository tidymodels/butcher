#' Axing an kknn.
#'
#' kknn objects are created from the \code{kknn} package, which is utilized to
#' do weighted k-Nearest Neighbors for classification, regression and clustering.
#' This is where all the kknn specific documentation lies.
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
#' # Axe
#' axe(kknn_fit)
#' @name axe-kknn
NULL

#' The call can be axed without breaking \code{predict}.
#'
#' @rdname axe-kknn
#' @export
axe_call.kknn <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' The environment located under terms can be replaced with the
#' \code{rlang::base_env()}.
#'
#' @rdname axe-kknn
#' @export
axe_env.kknn <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  x
}

#' Fitted values can be axed.
#'
#' @rdname axe-kknn
#' @export
axe_fitted.kknn <- function(x, ...) {
  x$fitted.values <- list(NULL)
  x
}

#' A number of misc values are stored from training that can be
#' axed without affecting \code{predict}. This includes the matrix
#' of misclassification errors \code{MISCLASS}, the matrix of mean
#' absolute errors \code{MEAN.ABS}, and the matrix of mean squared errors
#' \code{MEAN.SQU}.
#'
#' @rdname axe-kknn
#' @export
axe_misc.kknn <- function(x, ...) {
  x$MISCLASS <- numeric(0)
  x$MEAN.ABS <- numeric(0)
  x$MEAN.SQU <- numeric(0)
  x
}

#' @rdname axe-kknn
#' @export
predict.butcher_train.kknn <- function(x, ...) {
  class(x) <- c("train.kknn", "kknn")
  predict(x, ...)
}
