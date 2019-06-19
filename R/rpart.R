#' Axing a rpart.
#'
#' rpart objects are created from the \code{rpart} package, which
#' is used for recursive partitioning for classification, regression and
#' survival trees. This is where all the rpart specific documentation lies.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(tidymodels)))
#' suppressWarnings(suppressMessages(library(rpart)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#' car_test  <- testing(split)
#'
#' # Create model and fit
#' rpart_fit <- decision_tree(mode = "regression") %>%
#'   set_engine("rpart") %>%
#'   fit(mpg ~ ., data = car_train, minsplit = 5, cp = 0.1)
#' @name axe-rpart
NULL

#' Calls can be removed without breaking \code{predict}.
#'
#' @rdname axe-rpart
#' @export
axe_call.rpart <- function(x, ...) {
  x$call <- call("dummy_call")
  x$functions <- call("dummy_call")
  x
}

#' Most of control can be removed without breaking \code{predict}.
#' Currently it is replaced with a NULL list to
#' maintain the structure of the original rpart object.
#'
#' @rdname axe-rpart
#' @export
axe_ctrl.rpart <- function(x, ...) {
  surrogate <- x$control$usesurrogate
  x$control <- list(NULL)
  x$control$usesurrogate <- surrogate
  x
}

#' The environment stored under terms for an rpart object cannot just be
#' replaced with an empty environment. As indicated under \code{rpart::predict.rpart},
#' at some point \code{stats::model.frame.default} is called on the
#' terms object and the new data on which we want to carry out prediction.
#' Unfortunately, \code{stats::model.frame.default} relies on the \code{list}
#' function which it calls from a specific environment. We thus replace the
#' environment stored in the original rpart object with this parsed down
#' version of the environment to accomodate the means by which
#' \code{rpart::predict.rpart} works.
#'
#' @rdname axe-rpart
#' @export
axe_env.rpart <- function(x, ...) {
  attr(x$terms, ".Environment") <- rlang::base_env()
  x
}

#' Cptable can be removed. It stores the optimal prunings based on the
#' complexity parameter.
#'
#' @rdname axe-rpart
#' @export
axe_misc.rpart <- function(x, ...) {
  x$cptable <- numeric(0)
  x
}

#' The \code{predict.rpart} function relies on an underlying C function
#' to carry out prediction as illustrated in \code{rpart::pred.rpart}.
#' The parts of the model object that appear to have a role include the
#' frame, splits, csplit, and control$usesurrogate.
#'
#' @rdname axe-rpart
#' @export
predict.butcher_rpart <- function(x, ...) {
  class(x) <- c("rpart")
  predict(x, ...)
}

