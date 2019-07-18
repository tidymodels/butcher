#' Axing an multnet.
#'
#' This is where all the multnet specific documentation lies.
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
#' # Load data
#' set.seed(1234)
#' predictrs <- matrix(rnorm(100*20), ncol = 20)
#' response <- as.factor(sample(1:4, 100, replace = TRUE))
#'
#' # Create model and fi
#' multnet_fit <- multinom_reg() %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = predictrs, y = response)
#'
#' butcher(multnet_fit)
#'
#' @name axe-multnet
NULL

#' Remove call.
#'
#' @rdname axe-multnet
#' @export
axe_call.multnet <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print", "summary"),
    verbose = verbose
  )
}
