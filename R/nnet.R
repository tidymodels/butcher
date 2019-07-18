#' Axing a nnet.
#'
#' This is where all the nnet specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
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
axe_call.nnet <- function(x, verbose = TRUE, ...) {
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
axe_env.nnet <- function(x, verbose = TRUE, ...) {
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
axe_fitted.nnet <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "fitted",
      "predict(newdata = NA)",
      "dimnames(object$fitted.values)"
    ),
    verbose = verbose
  )
}

