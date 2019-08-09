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
#' suppressWarnings(suppressMessages(library(glmnet)))
#'
#' # Example 1
#' n <- 500
#' p <- 30
#' nzc <- trunc(p/10)
#' x <- matrix(rnorm(n*p), n, p)
#' beta <- matrix(rnorm(30), 10, nzc)
#' beta <- rbind(beta, matrix(0, p-10, nzc))
#' f <- x %*% beta
#' p <- exp(f)
#' p <- p/apply(p, 1, sum)
#' g <- rmult(p)
#' set.seed(10101)
#' cvfit <- cv.glmnet(x, g, family="multinomial", keep = TRUE)
#'
#' out <- butcher(cvfit, verbose = TRUE)
#'
#' # Example 2
#' n <- 1000
#' p <- 100
#' nzc <- trunc(p/10)
#' x <- matrix(rnorm(n*p), n, p)
#' beta <- rnorm(nzc)
#' fx <- x[, seq(nzc)] %*% beta
#' eps <- rnorm(n)*5
#' y <- drop(fx+eps)
#' px <- exp(fx)
#' px <- px/(1+px)
#' ly <- rbinom(n = length(px), prob = px, size = 1)
#' cvfit2 <- cv.glmnet(x, ly,
#'                     family = "binomial",
#'                     type.measure = "auc",
#'                     keep = TRUE)
#'
#' out <- butcher(cvfit2, verbose = TRUE)
#'
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
