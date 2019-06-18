#' Axing an elnet.
#'
#' This is where all the elnet specific documentation lies.
#'
#' Note: the elnet object is one of the few model objects in which
#' there is no environment to axe.
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
#' elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = select(car_train, -mpg), y = select(car_train, mpg))
#'
#' # Axe
#' axe(elnet_fit)
#' @name axe-elnet
NULL

#' Call can be removed without breaking \code{predict}.
#'
#' @rdname axe-elnet
#' @export
axe_call.elnet <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-elnet
#' @export
predict.butcher_elnet <- function(x, ...) {
  class(x) <- c("elnet", "glmnet")
  predict(x, ...)
}
