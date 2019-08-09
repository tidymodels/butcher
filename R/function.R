#' Axing functions.
#'
#' Functions stored in model objects often have heavy environments
#' and bytecode attached. To avoid breaking any post-estimation functions
#' on the model object, the \code{butchered_function} class is not
#' appended.
#'
#' @inheritParams butcher
#'
#' @return Axed function.
#'
#' @examples
#' \donttest{
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
#' out <- axe_env(train_fit$modelInfo$prob, verbose = TRUE)
#' out <- axe_env(train_fit$modelInfo$levels, verbose = TRUE)
#' out <- axe_env(train_fit$modelInfo$predict, verbose = TRUE)
#' }
#' @name axe-function
NULL

#' Remove the bytecode attached to function.
#'
#' @rdname axe-function
#' @export
axe_env.function <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- as.function(c(formals(x), body(x)), env = environment(x))

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

