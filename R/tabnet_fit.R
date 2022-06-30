#' Axing a tabnet_fit.
#'
#' @inheritParams butcher
#'
#' @return Axed tabnet_fit object.
#'
#' @examples
#' \donttest{
#' if (rlang::is_installed("tabnet")) {
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
#' }
#' }
#' @name axe-tabnet_fit
NULL

#' Remove the call.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_call._tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "tabnet_explain()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove controls used for training.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_ctrl._tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", "???")

  add_butcher_attributes(
    x,
    old,
    disabled = c("some_function()", "another_function()"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-tabnet_fit
#' @export
axe_fitted._tabnet_fit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fit.checkpoints", list(NULL))
  x <- exchange(x, "fit.importances.variables", list(NULL))
  x <- exchange(x, "fit.importances.importance", list(NULL))
  x <- exchange(x, "fit.config", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = NULL,
    add_class = FALSE,
    verbose = verbose
  )
}
