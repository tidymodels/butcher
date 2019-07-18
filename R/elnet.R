#' Axing an elnet.
#'
#' This is where all the elnet specific documentation lies.
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
#'
#' # Load data
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#' car_test  <- testing(split)
#'
#' # Create model and fit
#' elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = car_train[, 2:11], y = car_train[, 1, drop = FALSE])
#'
#' butcher(elnet_fit)
#'
#' @name axe-elnet
NULL

#' Remove the call.
#'
#' @rdname axe-elnet
#' @export
axe_call.elnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

