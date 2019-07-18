#' Axing a glmnet.
#'
#' This is where all the glmnet specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#' @examples
#' library(glmnet)
#' x <- model.matrix(mpg ~ ., data = mtcars)
#' y <- as.matrix(sample(c(1, 0), size = 32, replace = TRUE))
#' fit <- glmnet(x, as.factor(y), family = "binomial")
#'
#' butcher(fit)
#' @name axe-glmnet
NULL

#' Remove the call.
#'
#' @rdname axe-glmnet
#' @export
axe_call.glmnet <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print", "summary"),
    verbose = verbose
  )
}

