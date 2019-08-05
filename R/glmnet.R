#' Axing a glmnet.
#'
#' glmnet objects are created from the \pkg{glmnet} package, leveraged
#' to fit generalized linear models via penalized maximum likelihood.
#'
#' @inheritParams butcher
#'
#' @return Axed glmnet object.
#'
#' @examples
#' library(glmnet)
#' x <- model.matrix(mpg ~ ., data = mtcars)
#' y <- as.matrix(sample(c(1, 0), size = 32, replace = TRUE))
#' fit <- glmnet(x, as.factor(y), family = "binomial")
#'
#' butcher(fit)
#'
#' @name axe-glmnet
NULL

#' Remove the call.
#'
#' @rdname axe-glmnet
#' @export
axe_call.glmnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

