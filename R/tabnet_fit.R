#' Axing a tabnet_fit.
#'
#' @inheritParams butcher
#'
#' @return Axed tabnet_fit object.
#'
#' @examplesIf rlang::is_installed("tabnet")
#'
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rsample)))
#'
#' # Load data
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' mtcar_fit <- tabnet() %>%
#'   set_mode("regression") %>%
#'   set_engine("torch")
#'   fit(mpg ~ ., data = car_train)
#'
#' out <- butcher(mtcar_fit, verbose = TRUE)
#'
#' @name axe-tabnet_fit
NULL

#' Remove fitted values.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_fitted._tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x$fit$fit <- exchange(x$fit$fit, "checkpoints", list(NULL))
  x$fit$fit$importances <- exchange(x$fit$fit$importances, "variables", list(NULL))
  x$fit$fit$importances <- exchange(x$fit$fit$importances, "importance", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = NULL,
    add_class = FALSE,
    verbose = verbose
  )
}
