#' Axing an earth object.
#'
#' earth objects are created from the \pkg{earth} package, which
#' is leveraged to do multivariate adapative regression splines.
#' This is where all the earth specific documentation lies.
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
#'
#' # Create model and fit
#' earth_fit <- mars(mode = "regression") %>%
#'   set_engine("earth") %>%
#'   fit(Volume ~ ., data = trees)
#'
#' butcher(earth_fit)
#'
#' @name axe-earth
NULL

#' Remove the call.
#'
#' @rdname axe-earth
#' @export
axe_call.earth <- function(x, verbose = TRUE, ...) {
  old <- x
  x$call <- call("dummy_call")

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary", "update"),
    verbose = verbose
  )
}

#' Remove original data.
#'
#' @rdname axe-earth
#' @export
axe_data.earth <- function(x, verbose = TRUE, ...) {
  old <- x
  x$x <- data.frame(NA)
  x$y <- numeric(0)

  add_butcher_attributes(
    x,
    old,
    disabled = c("update"),
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-earth
#' @export
axe_fitted.earth <- function(x, verbose = TRUE, ...) {
  old <- x
  x$residuals <- numeric(0)

  add_butcher_attributes(
    x,
    old,
    disabled = c("residuals"),
    verbose = verbose
  )
}
