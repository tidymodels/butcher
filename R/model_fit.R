#' Axing an model_fit.
#'
#' model_fit objects are created from the \code{parsnip} package.
#'
#' @inheritParams butcher
#'
#' @return Axed model_fit object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "mgcv"))
#' library(parsnip)
#' library(rpart)
#'
#' # Create model and fit
#' lm_fit <- linear_reg() |>
#'   set_engine("lm") |>
#'   fit(mpg ~ ., data = mtcars)
#'
#' out <- butcher(lm_fit, verbose = TRUE)
#'
#' # Another parsnip model
#' gam_fit <- gen_additive_mod() |>
#'   set_mode("regression") |>
#'   fit(mpg ~ s(disp) + wt + gear, data = mtcars)
#'
#' out <- butcher(gam_fit, verbose = TRUE)
#'
#' @name axe-model_fit
NULL

#' @rdname axe-model_fit
#' @export
axe_call.model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- axe_call(x$fit, verbose = verbose, ...)
  add_butcher_attributes(x, old, verbose = verbose)
}

#' @rdname axe-model_fit
#' @export
axe_ctrl.model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- axe_ctrl(x$fit, verbose = verbose, ...)
  add_butcher_attributes(x, old, verbose = verbose)
}

#' @rdname axe-model_fit
#' @export
axe_data.model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- axe_data(x$fit, verbose = verbose, ...)
  add_butcher_attributes(x, old, verbose = verbose)
}

#' @rdname axe-model_fit
#' @export
axe_env.model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- axe_env(x$fit, verbose = verbose, ...)
  add_butcher_attributes(x, old, verbose = verbose)
}

#' @rdname axe-model_fit
#' @export
axe_fitted.model_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit <- axe_fitted(x$fit, verbose = verbose, ...)
  add_butcher_attributes(x, old, verbose = verbose)
}
