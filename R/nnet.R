#' Axing a nnet.
#'
#' nnet objects are created from the \pkg{nnet} package, leveraged to
#' fit multilayer perceptron models.
#'
#' @inheritParams butcher
#'
#' @return Axed nnet object.
#'
#' @examples
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(nnet)))
#' nnet_fit <- mlp("classification", hidden_units = 2) %>%
#'   set_engine("nnet") %>%
#'   fit(Species ~ ., data = iris)
#'
#' butcher(nnet_fit)
#' @name axe-nnet
NULL

#' Remove the call.
#'
#' @rdname axe-nnet
#' @export
axe_call.nnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}


#' Remove environments.
#'
#' @rdname axe-nnet
#' @export
axe_env.nnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-nnet
#' @export
axe_fitted.nnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "fitted()",
      "predict() with no new data",
      "dimnames(axed_object$fitted.values)"
    ),
    verbose = verbose
  )
}

