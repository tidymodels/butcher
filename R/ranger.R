#' Axing an ranger.
#'
#' ranger objects are created from the \code{ranger} package, which is used as
#' a means to quickly train random forests. The package supports ensembles
#' of classification, regression, survival and probability prediction trees.
#' This is where all the ranger specific documentation lies.
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
#' butcher(ranger_fit)
#'
#' @name axe-ranger
NULL

#' Remove the call.
#'
#' @rdname axe-ranger
#' @export
axe_call.ranger <- function(x, ...) {
  x$call <- call("dummy_call")
  add_butcher_class(x)
}

#' Remove predictions.
#'
#' @rdname axe-ranger
#' @export
axe_fitted.ranger <- function(x, ...) {
  x$predictions <- numeric(0)
  add_butcher_class(x)
}
