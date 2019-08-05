#' Axing an cv.glmnet.
#'
#' cv.glmnet objects are created from carrying out k-fold
#' cross-validation from the \pkg{glmnet} package.
#'
#' @inheritParams butcher
#'
#' @return Axed cv.glmnet object.
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
axe_fitted.cv.glmnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fit.preval", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
