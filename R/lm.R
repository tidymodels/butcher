#' Axing an lm.
#'
#' This is where all the lm specific documentation lies.
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

#' Remove the call.
#'
#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")
  x$call$offset <- old$call$offset

  add_butcher_attributes(x, old,
                         disabled = c("print", "summary"),
                         verbose = verbose)
}

#' Remove the environment. The same environment is referenced in terms
#' as well as model attribute, both need to be addressed in order for
#' the environment to be completely replaced.
#'
#' @rdname axe-lm
#' @export
axe_env.lm <- function(x, verbose = TRUE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(x, old,
                         verbose = verbose)
}

#' Remove fitted values.
#'
#' @rdname axe-lm
#' @export
axe_fitted.lm <- function(x, verbose = TRUE, ...) {
  old <- x
  x$fitted.values <- numeric(0)

  add_butcher_attributes(x, old,
                         disabled = c("fitted", "summary"),
                         verbose = verbose)
}

