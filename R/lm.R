#' Axing an lm.
#'
#' This is where all the lm specific documentation lies.
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
#'
#' # Load data
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#' car_test  <- testing(split)
#'
#' # Create model and fit
#' lm_fit <- linear_reg() %>%
#'   set_engine("lm") %>%
#'   fit(mpg ~ ., data = car_train)
#'
#' butcher(lm_fit)
#'
#' @name axe-lm
NULL

#' Remove the call. Note that there may be a rare \code{offset} feature
#' stored in the call which may be utilized in \code{predict}.
#'
#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' Remove the environment. The same environment is referenced in terms
#' as well as model attribute, both need to be addressed in order for
#' the environment to be completely replaced.
#'
#' @rdname axe-lm
#' @export
axe_env.lm <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' Remove fitted values.
#'
#' @rdname axe-lm
#' @export
axe_fitted.lm <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

