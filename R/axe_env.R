#' Axe an environment.
#'
#' Remove the environment(s) attached to modeling objects as they are often
#' not required in the downstream analysis pipeline. Currently, if found,
#' the environment is completely removed. In future iterations, we might
#' want to consider replacing the environment object with a rlang::empty_env().
#'
#' @param x model object
#'
#' @return model object without environment attribute
#' @export
#' @examples
#' axe_env(lm_fit)
axe_env <- function(x, ...) {
  UseMethod("axe_env")
}

#' @export
axe_env.default <- function(x, ...) {
  # No environment to replace
  x
}

#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}

#' @export
axe_env.data.frame <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}

#' @export
axe_env.lm <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @export
axe_env.glm <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.glmnet <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.elnet <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.stanreg <- function(x, ...) {
  # TODO: check differences between glm and stanreg objects
  # Replace the `.MISC` slot with an empty env
  x$stanfit@.MISC <- rlang::empty_env()
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @export
axe_env.keras.engine.sequential.Sequential <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.keras.engine.training.Model <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.rpart <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  x
}

#' @export
axe_env.C5.0 <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.multnet <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.train.kknn <- function(x, ...) {
  NextMethod("axe_env")
}

#' @export
axe_env.kknn <- function(x, ...) {
  x$terms <- axe_env(x$terms, ...)
  x
}

#' @export
axe_env.randomForest <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.ranger <- function(x, ...) {
  axe_env.default(x, ...)
}

#' @export
axe_env.flexsurvreg <- function(x, ...) {
  attributes(x$data$m)$terms <- axe_env(attributes(x$data$m)$terms)
  attributes(x$concat.formula)$`.Environment` <- rlang::empty_env()
  attributes(x$all.formulae$rate)$`.Environment` <- rlang::empty_env()
  x
}

#' @export
axe_env.survreg <- function(x, ...) {
  # Environment in terms
  x$terms <- axe_env(x$terms, ...)
  # Environment in model
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)
  x
}

#' @export
axe_env.model_fit <- function(x, ...) {
  # Extract the x$fit object from parsnip for post-processing
  axe_env(x$fit, ...)
}
