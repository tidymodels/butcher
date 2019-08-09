#' Axing an model_fit.
#'
#' model_fit objects are created from the \code{parsnip} package.
#'
#' @inheritParams butcher
#'
#' @return Axed model_fit object.
#'
#' @examples
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rpart)))
#' suppressWarnings(suppressMessages(library(glmnet)))
#'
#' # Create model and fit
#' lm_fit <- linear_reg() %>%
#'   set_engine("lm") %>%
#'   fit(mpg ~ ., data = mtcars)
#'
#' out <- butcher(lm_fit, verbose = TRUE)
#'
#' # Another parsnip model
#' elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = mtcars[, 2:11], y = mtcars[, 1, drop = FALSE])
#'
#' out <- butcher(elnet_fit, verbose = TRUE)
#'
#' # Another parsnip model
#' rpart_fit <- decision_tree(mode = "regression") %>%
#'   set_engine("rpart") %>%
#'   fit(mpg ~ ., data = mtcars, minsplit = 5, cp = 0.1)
#'
#' out <- butcher(rpart_fit, verbose = TRUE)
#'
#' @name axe-model_fit
NULL

#' @rdname axe-model_fit
#' @export
axe_call.model_fit <- function(x, verbose = FALSE, ...) {
  axe_call(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_ctrl.model_fit <- function(x, verbose = FALSE, ...) {
  axe_ctrl(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_data.model_fit <- function(x, verbose = FALSE, ...) {
  axe_data(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_env.model_fit <- function(x, verbose = FALSE, ...) {
  axe_env(x$fit, verbose = verbose, ...)
}

#' @rdname axe-model_fit
#' @export
axe_fitted.model_fit <- function(x, verbose = FALSE, ...) {
  axe_fitted(x$fit, verbose = verbose, ...)
}


