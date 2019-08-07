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
#' # Simple function
#' f <- function() {
#'   x <- runif(10e4)
#' }
#'
#' axed_f <- axe_env(f, verbose = TRUE)
#'
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
#' axe_env(train_fit$modelInfo$prob)
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

