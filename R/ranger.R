#' Axing an ranger.
#'
#' ranger objects are created from the \pkg{ranger} package, which is
#' used as a means to quickly train random forests. The package supports
#' ensembles of classification, regression, survival and probability
#' prediction trees. Given the reliance of post processing functions on
#' the model object, like \code{importance_pvalues} and \code{treeInfo},
#' on the first class listed, the \code{butcher_ranger} class is not
#' appended. This is where all the ranger specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
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
axe_call.ranger <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")

  add_butcher_attributes(
    x,
    old,
    disabled = c("print", "summary"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove predictions.
#'
#' @rdname axe-ranger
#' @export
axe_fitted.ranger <- function(x, verbose = TRUE, ...) {
  old <- x
  x$predictions <- numeric(0)

  add_butcher_attributes(
    x,
    old,
    disabled = c("predictions"),
    add_class = FALSE,
    verbose = verbose
  )
}
