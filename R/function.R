#' Axing functions.
#'
#' Functions stored in model objects often have heavy environments
#' and bytecode attached.
#'
#' @param x Function.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed function.
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
#' @name axe-function
NULL

#' Remove the bytecode attached to function.
#'
#' @rdname axe-function
#' @export
axe_env.function <- function(x, ...) {
  x <- as.function(c(formals(x), body(x)), env = environment(x))
  x
}

