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
#'
#' # Create model and fit
#' lm_fit <- linear_reg() %>%
#'   set_engine("lm") %>%
#'   fit(mpg ~ ., data = mtcars)
#'
#' butcher(lm_fit)
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


