#' Axing an cv.glmnet.
#'
#' This is where all the cv.glmnet specific documentation lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#'
#' @examples
#' # Load libraries
#' library(glmnet)
#' n <- 500;p <- 30
#' nzc <- trunc(p/10)
#' x <- matrix(rnorm(n*p), n, p)
#' beta3 <- matrix(rnorm(30), 10, nzc)
#' beta3 <- rbind(beta3, matrix(0, p-10, nzc))
#' f3 <- x %*% beta3
#' p3 <- exp(f3)
#' p3 <- p3/apply(p3, 1, sum)
#' g3 <- rmult(p3)
#' set.seed(10101)
#' cvfit <- cv.glmnet(x, g3, family="multinomial", keep = TRUE)
#'
#' butcher(cvfit)
#' @name axe-cv.glmnet
NULL

#' Remove prevalidated fits.
#'
#' @rdname axe-cv.glmnet
#' @export
axe_fitted.cv.glmnet <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "fit.preval", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
