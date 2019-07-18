#' Axing an kknn.
#'
#' kknn objects are created from the \pkg{kknn} package, which is
#' utilized to do weighted k-Nearest Neighbors for classification,
#' regression and clustering. This is where all the kknn specific
#' documentation lies.
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
#' spine_test  <- testing(split)
#'
#' # Create model and fit
#' kknn_fit <- nearest_neighbor(mode = "classification",
#'                              neighbors = 3,
#'                              weight_func = "gaussian",
#'                              dist_power = 2) %>%
#'   set_engine("kknn") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' butcher(kknn_fit)
#'
#' @name axe-kknn
NULL

#' Remove the call.
#'
#' @rdname axe-kknn
#' @export
axe_call.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove the environment.
#'
#' @rdname axe-kknn
#' @export
axe_env.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-kknn
#' @export
axe_fitted.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", list(NULL))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
