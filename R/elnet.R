#' Axing an elnet.
#'
#' elnet objects are created from the \pkg{glmnet} package, leveraged
#' to fit generalized linear models via penalized maximum likelihood.
#'
#' @inheritParams butcher
#'
#' @return Axed model object.
#'
#' @examplesIf rlang::is_installed("glmnet")
#' # Load libraries
#' library(parsnip)
#' library(rsample)
#'
#' # Load data
#' split <- initial_split(mtcars, prop = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) |>
#'   set_engine("glmnet") |>
#'   fit_xy(x = car_train[, 2:11], y = car_train[, 1, drop = FALSE])
#'
#' out <- butcher(elnet_fit, verbose = TRUE)
#'
#' @name axe-elnet
NULL

#' Remove the call.
#'
#' @rdname axe-elnet
#' @export
axe_call.elnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}
