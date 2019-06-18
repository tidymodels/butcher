#' Axing an ranger.
#'
#' This is where all the ranger specific documentation lies.
#'
#' @name axe-ranger
NULL

#' @rdname axe-ranger
#' @export
axe.ranger <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_ranger"
  x
}

#' @rdname axe-ranger
#' @export
axe_call.ranger <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-ranger
#' @export
axe_ctrl.ranger <- function(x, ...) {
  # Number of variables to split at each node
  x$mtry <- NULL
  # Min node size
  x$min.node.size <- NULL
  # Splitting rule
  x$splitrule <- NULL
  # Sample with replacement
  x$replace <- NULL
  # Number of samples
  x$num.samples <- NULL
  x
}

#' @rdname axe-ranger
#' @export
axe_env.ranger <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-ranger
#' @export
axe_fitted.ranger <- function(x, ...) {
  # The `predict.ranger` function requires new data to be supplied
  x$predictions <- NULL
  x
}

#' @rdname axe-ranger
#' @export
axe_misc.ranger <- function(x, ...) {
  # Out-of-bag prediction error
  x$prediction.error <- NULL
  x
}

#' @rdname axe-ranger
#' @export
predict.butcher_ranger <- function(x, ...) {
  class(x) <- "ranger"
  predict(x, ...)
}

