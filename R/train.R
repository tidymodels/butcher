#' Axing a train object.
#'
#' train objects are created from the \pkg{caret} package.
#'
#' @inheritParams butcher
#'
#' @return Axed train object.
#'
#' @examplesIf rlang::is_installed("caret")
#' # Load libraries
#' library(caret)
#'
#' data(iris)
#' train_data <- iris[, 1:4]
#' train_classes <- iris[, 5]
#'
#' train_fit <- train(train_data, train_classes,
#'                    method = "knn",
#'                    preProcess = c("center", "scale"),
#'                    tuneLength = 10,
#'                    trControl = trainControl(method = "cv"))
#'
#' out <- butcher(train_fit, verbose = TRUE)
#'
#' @name axe-train
NULL

#' Remove the call.
#'
#' @rdname axe-train
#' @export
axe_call.train <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))
  x <- exchange(x, "dots", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary()"),
    verbose = verbose
  )
}

#' Remove controls.
#'
#' @rdname axe-train
#' @export
axe_ctrl.train <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", list(NULL), "method", old)

  add_butcher_attributes(
    x,
    old,
    disabled = "update()",
    verbose = verbose
  )
}

#' Remove training data.
#'
#' @rdname axe-train
#' @export
axe_data.train <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "trainingData", data.frame(NA))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove environments associated with \code{srcref}.
#'
#' @rdname axe-train
#' @export
axe_env.train <- function(x, verbose = FALSE, ...) {
  old <- x
  x$modelInfo <- purrr::map(x$modelInfo, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-train
#' @export
axe_fitted.train <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "pred", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = "residuals()",
    verbose = verbose
  )
}
