#' Axing functions.
#'
#' functions often wrap environments that carry a lot of unneccesary junk.
#'
#' @param x function
#' @param ... any additional arguments related to axing
#'
#' @return axed function
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

#' Remove the environment.
#'
#' @rdname axe-function
#' @export
axe_env.function <- function(x, ...) {
  if(is.null(attr(x, "srcref"))) {
    x <- rlang::set_env(x, rlang::base_env())
  }
  add_butcher_class(x)
}

