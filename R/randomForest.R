#' Axing an randomForest.
#'
#' randomForest objects are created from the \code{randomForest} package,
#' which is used to train random forests based on Breiman et al's 2001 work.
#' The package supports ensembles of classification and regression trees.
#' This is where all the randomForest specific documentation lies.
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
#' suppressWarnings(suppressMessages(library(rpart)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, props = 9/10)
#' spine_train <- training(split)
#'
#' # Create model and fit
#' randomForest_fit <- rand_forest(mode = "classification",
#'                                 mtry = 2,
#'                                 trees = 2,
#'                                 min_n = 3) %>%
#'   set_engine("randomForest") %>%
#'   fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)
#'
#' butcher(randomForest_fit)
#'
#' @name axe-randomForest
NULL

#' Remove the call.
#'
#' @rdname axe-randomForest
#' @export
axe_call.randomForest <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")
  if (verbose) {
    assess_object(old, x,
                  disabled = c("print", "summary"))
  }
  add_butcher_class(x)
}

#' Remove controls.
#'
#' @rdname axe-randomForest
#' @export
axe_ctrl.randomForest <- function(x, verbose = TRUE, ...) {
  old <- x
  x$inbag <- matrix(NA)
  if (verbose) {
    assess_object(old, x)
  }
  add_butcher_class(x)
}

#' Remove the environment.
#'
#' @rdname axe-randomForest
#' @export
axe_env.randomForest <- function(x, verbose = TRUE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  if (verbose) {
    assess_object(old, x)
  }
  add_butcher_class(x)
}
