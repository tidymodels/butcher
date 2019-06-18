#' Axing an randomForest.
#'
#' This is where all the randomForest specific documentation lies.
#'
#' @name axe-randomForest
NULL

#' @rdname axe-randomForest
#' @export
axe.randomForest <- function(x, ...) {
  x <- axe_call(x)
  x <- axe_env(x)
  x <- axe_fitted(x)
  class(x) <- "butcher_randomForest"
  x
}

#' @rdname axe-randomForest
#' @export
axe_call.randomForest <- function(x, ...) {
  x$call <- call("dummy_call")
  x
}

#' @rdname axe-randomForest
#' @export
axe_ctrl.randomFoest <- function(x, ...) {
  # Number of trees grown
  x$ntree <- NULL
  # Number of predictors sampled
  x$mtry <- NULL
  x
}

#' @rdname axe-randomForest
#' @export
axe_env.randomForest <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @rdname axe-randomForest
#' @export
axe_fitted.randomForest <- function(x, ...) {
  x$fitted.values <- numeric(0)
  x
}

#' @rdname axe-randomForest
#' @export
axe_misc.randomForest <- function(x, ...) {
  # Number of times cases are out-of-bag and used to compute OOB error
  x$oob.times <- NULL
  # (Classification) vector error rates
  x$err.rate <- NULL
  # (Classification) confusion matrix
  x$confusion <- NULL
  # Number of samples inbag
  x$inbag <- NULL
  x
}

#' @rdname axe-randomForest
#' @export
predict.butcher_randomForest <- function(x, ...) {
  class(x) <- "randomForest"
  predict(x, ...)
}

