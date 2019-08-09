#' Axing an ranger.
#'
#' ranger objects are created from the \pkg{ranger} package, which is
#' used as a means to quickly train random forests. The package supports
#' ensembles of classification, regression, survival and probability
#' prediction trees. Given the reliance of post processing functions on
#' the model object, like \code{importance_pvalues} and \code{treeInfo},
#' on the first class listed, the \code{butcher_ranger} class is not
#' appended.
#'
#' @inheritParams butcher
#'
#' @return Axed ranger object.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rsample)))
#' suppressWarnings(suppressMessages(library(ranger)))
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
#' out <- butcher(ranger_fit, verbose = TRUE)
#'
#' # Another ranger object
#' wrapped_ranger <- function() {
#'   n <- 100
#'   p <- 400
#'   dat <- data.frame(y = factor(rbinom(n, 1, .5)), replicate(p, runif(n)))
#'   fit <- ranger(y ~ ., dat, importance = "impurity_corrected")
#'   return(fit)
#' }
#'
#' cleaned_ranger <- axe_fitted(wrapped_ranger(), verbose = TRUE)
#'
#' @name axe-ranger
NULL

#' Remove the call.
#'
#' @rdname axe-ranger
#' @export
axe_call.ranger <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove predictions.
#'
#' @rdname axe-ranger
#' @export
axe_fitted.ranger <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "predictions", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("predictions()"),
    add_class = FALSE,
    verbose = verbose
  )
}
