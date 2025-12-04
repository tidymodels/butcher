#' Axing a MASS discriminant analysis object.
#'
#' lda and qda objects are created from the \pkg{MASS} package, leveraged to
#' carry out linear discriminant analysis and quadratic discriminant
#' analysis, respectively.
#'
#' @inheritParams butcher
#'
#' @return Axed lda or qda object.
#'
#' @examplesIf rlang::is_installed("MASS")
#' library(MASS)
#'
#' fit_da <- function(fit_fn) {
#'   boop <- runif(1e6)
#'   fit_fn(y ~ x, data.frame(y = rep(letters[1:4], 10000), x = rnorm(40000)))
#' }
#'
#' lda_fit <- fit_da(lda)
#' qda_fit <- fit_da(qda)
#'
#' lda_fit_b <- butcher(lda_fit)
#' qda_fit_b <- butcher(qda_fit)
#'
#' weigh(lda_fit)
#' weigh(lda_fit_b)
#'
#' weigh(qda_fit)
#' weigh(qda_fit_b)
#'
#' wrapped_polr <- function(fit_fn) {
#'   boop <- runif(1e6)
#'   fit <- fit_fn(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
#'   return(fit)
#' }
#' polr_fit <- wrapped_polr(polr)
#' polr_fit_b <- butcher(polr_fit)
#' weigh(polr_fit)
#' weigh(polr_fit_b)
#'
#' @name axe-mass
#' @aliases axe-lda
#' @aliases axe-qda
NULL

#' @rdname axe-mass
#' @export
axe_env.lda <- function(x, verbose = FALSE, ...) {
  res <- x
  res$terms <- axe_env(res$terms, ...)

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-mass
#' @export
axe_env.qda <- axe_env.lda

#' @rdname axe-mass
#' @export
axe_env.polr <- axe_env.lda
