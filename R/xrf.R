#' Axing a xrf.
#'
#' @inheritParams butcher
#'
#' @return Axed xrf object.
#'
#' @examplesIf rlang::is_installed("xrf")
#' library(xrf)
#'
#' xrf_big <- function() {
#'   boop <- runif(1e6)
#'   xrf(
#'     mpg ~ .,
#'     mtcars,
#'     xgb_control = list(nrounds = 2, max_depth = 2),
#'     family = 'gaussian'
#'   )
#' }
#'
#' heavy_m <- xrf_big()
#'
#' m <- butcher(heavy_m, verbose = TRUE)
#'
#' weigh(heavy_m)
#' weigh(m)
#'
#' @name axe-xrf
NULL

#' @rdname axe-xrf
#' @export
axe_call.xrf <- function(x, verbose = FALSE, ...) {
  res <- x
  res$xgb <- axe_call(res$xgb)
  res$glm$model$glmnet.fit$call <- call("dummy_call")
  res$glm$model$call <- call("dummy_call")

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-xrf
#' @export
axe_env.xrf <- function(x, verbose = FALSE, ...) {
  res <- x
  res$base_formula <- axe_env(res$base_formula, ...)
  res$rule_augmented_formula <- axe_env(res$rule_augmented_formula, ...)
  res$glm$formula <- axe_env(res$glm$formula, ...)
  res$xgb <- axe_env(res$xgb, ...)

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}




