#' Axing a glmnet.
#'
#' glmnet objects are created from the \pkg{glmnet} package, leveraged
#' to fit generalized linear models via penalized maximum likelihood.
#'
#' @inheritParams butcher
#'
#' @return Axed glmnet object.
#'
#' @examplesIf rlang::is_installed("glmnet")
#' library(parsnip)
#'
#' # Wrap a parsnip glmnet model
#' wrapped_parsnip_glmnet <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   model <- logistic_reg(penalty = 10, mixture = 0.1) |>
#'     set_engine("glmnet") |>
#'     fit(as.factor(vs) ~ ., data = mtcars)
#'   return(model$fit)
#' }
#'
#' out <- butcher(wrapped_parsnip_glmnet(), verbose = TRUE)
#'
#' @name axe-glmnet
NULL

#' Remove the call.
#'
#' @rdname axe-glmnet
#' @export
axe_call.glmnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}
