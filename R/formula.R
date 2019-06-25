#' Axing formulas.
#'
#' formulas often wrap environments that carry a lot of unneccesary junk.
#'
#' @param x formula
#' @param ... any additional arguments related to axing
#'
#' @return axed formula
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
#' axe_env(train_fit$modelInfo$prob)
#'
#' @name axe-formula
NULL

#' Remove the environment.
#'
#' @rdname axe-formula
#' @export
axe_env.formula <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}
