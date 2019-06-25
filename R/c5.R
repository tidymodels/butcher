#' Axing a C5.0.
#'
#' C5.0 objects are created from the \code{C50} package, which provides an
#' interface to the C5.0 classification model. The models that can be
#' generated include basic tree-based models as well as rule-based models.
#' This is where all the C5.0 specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#' suppressWarnings(suppressMessages(library(rpart)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, props = 9/10)
#' spine_train <- training(split)
#'
#' # Create model and fit
#' c5_fit <- decision_tree(mode = "classification") %>%
#'   set_engine("C5.0") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' butcher(c5_fit)
#'
#' @name axe-C5.0
NULL

#' Remove the call. Note that \code{summary} will be broken once this
#' call is removed.
#'
#' @rdname axe-C5.0
#' @export
axe_call.C5.0 <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' Remove controls.
#'
#' @rdname axe-C5.0
#' @export
axe_ctrl.C5.0 <- function(x, ...) {
  x$control <- list(NULL)
  x
}

#' Remove fitted values. Note a single text string of the model fit
#' is removed here, thus distorting the \code{summary} output; however,
#' \code{predict} still works.
#'
#' @rdname axe-C5.0
#' @export
axe_fitted.C5.0 <- function(x, ...) {
  x$output <- character(0)
  x
}

