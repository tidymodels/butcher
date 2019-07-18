#' Axing a C5.0.
#'
#' C5.0 objects are created from the \code{C50} package, which provides an
#' interface to the C5.0 classification model. The models that can be
#' generated include basic tree-based models as well as rule-based models.
#' This is where all the C5.0 specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{FALSE}.
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
#' c5_fit <- decision_tree(mode = "classification") %>%
#'   set_engine("C5.0") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' out <- butcher(c5_fit)
#'
#' @name axe-C5.0
NULL

#' Remove the call.
#'
#' @rdname axe-C5.0
#' @export
axe_call.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove controls.
#'
#' @rdname axe-C5.0
#' @export
axe_ctrl.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = c("C5.0Control()", "C5imp()"),
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-C5.0
#' @export
axe_fitted.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "output", character(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary()", "C5.0Control()", "C5imp()"),
    verbose = verbose
  )
}
