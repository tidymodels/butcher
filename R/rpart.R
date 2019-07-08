#' Axing a rpart.
#'
#' rpart objects are created from the \code{rpart} package, which
#' is used for recursive partitioning for classification, regression and
#' survival trees. This is where all the rpart specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rsample)))
#' suppressWarnings(suppressMessages(library(rpart)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' rpart_fit <- decision_tree(mode = "regression") %>%
#'   set_engine("rpart") %>%
#'   fit(mpg ~ ., data = car_train, minsplit = 5, cp = 0.1)
#'
#' butcher(rpart_fit)
#'
#' @name axe-rpart
NULL

#' Remove calls.
#'
#' @rdname axe-rpart
#' @export
axe_call.rpart <- function(x, ...) {
  x$call <- call("dummy_call")
  x$functions <- call("dummy_call")
  x
}

#' Remove controls.
#'
#' @rdname axe-rpart
#' @export
axe_ctrl.rpart <- function(x, ...) {
  surrogate <- x$control$usesurrogate
  x$control <- list(NULL)
  x$control$usesurrogate <- surrogate
  add_butcher_class(x)
}

#' Remove the environment.
#'
#' @rdname axe-rpart
#' @export
axe_env.rpart <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  add_butcher_class(x)
}


