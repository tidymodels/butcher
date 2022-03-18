#' Axing a glm.
#'
#' glm objects are created from the base \pkg{stats} package.
#'
#' @inheritParams butcher
#'
#' @return Axed glm object.
#'
#' @examples
#'
#' cars_glm <- glm(mpg ~ ., data = mtcars)
#' cleaned_glm <- butcher(cars_glm, verbose = TRUE)
#'
#' @name axe-glm
NULL

#' Remove the call.
#'
#' @rdname axe-glm
#' @export
axe_call.glm <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    add_class = TRUE,
    verbose = verbose
  )
}

#' Remove the training data.
#'
#' @rdname axe-glm
#' @export
axe_data.glm <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "data", data.frame(NA))
  x <- exchange(x, "y", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the environments.
#'
#' @rdname axe-glm
#' @export
axe_env.glm <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)
  x$family$variance <- axe_env(x$family$variance, ...)
  x$family$dev.resids <- axe_env(x$family$dev.resids, ...)
  x$family$aic <- axe_env(x$family$aic, ...)
  x$family$validmu <- axe_env(x$family$validmu, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-glm
#' @export
axe_fitted.glm <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("fitted()", "summary()", "residuals()"),
    verbose = verbose
  )
}
