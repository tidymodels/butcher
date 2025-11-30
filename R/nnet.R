#' Axing a nnet.
#'
#' nnet objects are created from the \pkg{nnet} package, leveraged to
#' fit multilayer perceptron models.
#'
#' @inheritParams butcher
#'
#' @return Axed nnet object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "nnet"))
#' # Load libraries
#' library(parsnip)
#' library(nnet)
#'
#' # Create and fit model
#' nnet_fit <- mlp("classification", hidden_units = 2) %>%
#'   set_engine("nnet") %>%
#'   fit(Species ~ ., data = iris)
#'
#' out <- butcher(nnet_fit, verbose = TRUE)
#'
#' # Another nnet object
#' targets <- class.ind(c(rep("setosa", 50),
#'                        rep("versicolor", 50),
#'                        rep("virginica", 50)))
#'
#' fit <- nnet(iris[,1:4],
#'             targets,
#'             size = 2,
#'             rang = 0.1,
#'             decay = 5e-4,
#'             maxit = 20)
#'
#' out <- butcher(fit, verbose = TRUE)
#'
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

