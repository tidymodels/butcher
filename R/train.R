#' Axing a train object.
#'
#' This is where all the train specific documentation lies.
#'
#' @param x train object
#' @param ... any additional arguments related to axing
#'
#' @return axed train object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(caret)))
#'
#' data(iris)
#' train_data <- iris[, 1:4]
#' train_classes <- iris[, 5]
#'
#' train_fit <- train(train_data, train_classes,
#'                    method = "knn",
#'                    preProcess = c("center", "scale"),
#'                    tuneLength = 10,
#'                    trControl = trainControl(method = "cv"))
#'
#' out <- butcher(train_fit)
#'
#' @name axe-train
NULL

#' Remove the call.
#'
#' @rdname axe-train
#' @export
axe_call.train <- function(x, ...) {
  x$call <- call("dummy_call")
  x$dots <- list(NULL)
  x
}

#' Remove controls.
#'
#' @rdname axe-train
#' @export
axe_ctrl.train <- function(x, ...) {
  temp <- x$control$method
  x$control <- list(NULL)
  x$control$method <- temp
  x
}

#' Remove training data.
#'
#' @rdname axe-train
#' @export
axe_data.train <- function(x, ...) {
  x$trainingData <- data.frame(NA)
  x
}

#' Remove environments associated with \code{srcref}.
#'
#' @rdname axe-train
#' @export
axe_env.train <- function(x, ...) {
  x$modelInfo <- purrr::map(x$modelInfo, function(z) axe_env(z, ...))
  x
}

#' Remove fitted values.
#'
#' @rdname axe-train
#' @export
axe_fitted.train <- function(x, ...) {
  x$pred <- list(NULL)
  x
}
