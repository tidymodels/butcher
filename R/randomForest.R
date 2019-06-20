#' Axing an randomForest.
#'
#' randomForest objects are created from the \code{randomForest} package,
#' which is used to train random forests based on Breiman et al's 2001 work.
#' The package supports ensembles of classification and regression trees.
#' This is where all the randomForest specific documentation lies.
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
#' spine_test  <- testing(split)
#'
#' # Create model and fit
#' randomForest_fit <- rand_forest(mode = "classification",
#'                                 mtry = 2,
#'                                 trees = 2,
#'                                 min_n = 3) %>%
#'   set_engine("randomForest") %>%
#'   fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)
#'
#' # Axe
#' axe(randomForest_fit)
#'
#' @name axe-randomForest
NULL

#' The call object can be removed without breaking \code{predict}.
#'
#' @rdname axe-randomForest
#' @export
axe_call.randomForest <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' A number of control parameters used for training can be removed,
#' includes the number of trees grown \code{ntree} and the number of predictors
#' sampled at each split \code{mtry}.
#'
#' @rdname axe-randomForest
#' @export
axe_ctrl.randomFoest <- function(x, ...) {
  x$ntree <- numeric(0)
  x$mtry <- numeric(0)
  x
}

#' A number of misc parameters used for fitting the randomForest object
#' are stored, but unnecessary for \code{predict}. This includes the
#' number of times cases are out-of-bag \code{oob.times}, the classification
#' error rates \code{err.rate}, the confusion matrix \code{confusion}, and
#' the number of samples inbag \code{inbag}.
#'
#' @rdname axe-randomForest
#' @export
axe_misc.randomForest <- function(x, ...) {
  x$oob.times <- numeric(0)
  x$inbag <- numeric(0)
  if(x$type == "classification") {
    x$err.rate <- numeric(0)
    x$confusion <- numeric(0)
  }
  x
}

#' @rdname axe-randomForest
#' @export
predict.butcher_randomForest <- function(x, ...) {
  class(x) <- "randomForest"
  predict(x, ...)
}
