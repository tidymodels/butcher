#' Axing an earth object.
#'
#' earth objects are created from the \code{earth} package, which
#' is leveraged to do multivariate adapative regression splines.
#' This is where all the earth specific documentation lies.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
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
axe_call.earth <- function(x, ...) {
  x$call <- call("dummy_call")
  add_butcher_class(x)
}

#' Remove original data.
#'
#' @rdname axe-earth
#' @export
axe_data.earth <- function(x, ...) {
  x$x <- data.frame(NA)
  x$y <- numeric(0)
  add_butcher_class(x)
}

#' Remove fitted values.
#'
#' @rdname axe-earth
#' @export
axe_fitted.earth <- function(x, ...) {
  x$residuals <- numeric(0)
  add_butcher_class(x)
}

