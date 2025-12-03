#' Axing an earth object.
#'
#' earth objects are created from the \pkg{earth} package, which
#' is leveraged to do multivariate adaptive regression splines.
#'
#' @inheritParams butcher
#'
#' @return Axed earth object.
#'
#' @examplesIf rlang::is_installed("parsnip")
#' # Load libraries
#' library(parsnip)
#'
#' # Create model and fit
#' earth_fit <- mars(mode = "regression") |>
#'   set_engine("earth") |>
#'   fit(Volume ~ ., data = trees)
#'
#' out <- butcher(earth_fit, verbose = TRUE)
#'
#' # Another earth model object
#' suppressWarnings(suppressMessages(library(earth)))
#' earth_mod <- earth(Volume ~ ., data = trees)
#' out <- butcher(earth_mod, verbose = TRUE)
#'
#' @name axe-earth
NULL

#' Remove the call.
#'
#' @rdname axe-earth
#' @export
axe_call.earth <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary()", "update()"),
    verbose = verbose
  )
}

#' Remove original data.
#'
#' @rdname axe-earth
#' @export
axe_data.earth <- function(x, verbose = FALSE, ...) {
  old <- x

  # xy interface
  x <- exchange(x, "x", data.frame(NA))
  x <- exchange(x, "y", numeric(0))

  # formula interface
  x <- exchange(x, "data", data.frame(NA))

  add_butcher_attributes(
    x,
    old,
    disabled = c("update()"),
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-earth
#' @export
axe_fitted.earth <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "residuals", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("residuals()"),
    verbose = verbose
  )
}
