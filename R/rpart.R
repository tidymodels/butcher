#' Axing a rpart.
#'
#' rpart objects are created from the \pkg{rpart} package, which
#' is used for recursive partitioning for classification, regression and
#' survival trees. This is where all the rpart specific documentation lies.
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
axe_call.rpart <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")
  x$functions <- call("dummy_call")

  add_butcher_attributes(x, old,
                         disabled = c("summary", "printcp"),
                         verbose = verbose)
}

#' Remove controls.
#'
#' @rdname axe-rpart
#' @export
axe_ctrl.rpart <- function(x, verbose = TRUE, ...) {
  old <- x
  x$control <- list(NULL)
  x$control$usesurrogate <- old$control$usesurrogate

  add_butcher_attributes(x, old,
                         verbose = verbose)
}

#' Remove data.
#'
#' @rdname axe-rpart
#' @export
axe_data.rpart <- function(x, verbose = TRUE, ...) {
  old <- x
  x$y <- numeric(0)
  x$x <- matrix(NA)

  add_butcher_attributes(x, old,
                         disabled = c("xpred.rpart"),
                         verbose = verbose)
}

#' Remove the environment.
#'
#' @rdname axe-rpart
#' @export
axe_env.rpart <- function(x, verbose = TRUE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}


