#' Axing a rpart.
#'
#' This is where all the rpart specific documentation lies.
#'
#' @name axe-rpart
NULL

#' @rdname axe-rpart
#' @export
axe.rpart <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_ctrl(x)
  x <- axe_env(x)
  class(x) <- "butcher_rpart"
  x
}

#' @rdname axe-rpart
#' @export
axe_call.rpart <- function(x, ...) {
  x$call <- call("dummy_call")
  # Calls also located in `function`
  x$functions <- call("dummy_call")
  x
}

#' @rdname axe-rpart
#' @export
axe_ctrl.rpart <- function(x, ...) {
  x$control <- list(NULL)
  x
}

#' @export
axe_env.rpart <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  x
}

#' @rdname axe-rpart
#' @export
predict.butcher_rpart <- function(x, ...) {
  class(x) <- c("rpart")
  predict(x, ...)
}

