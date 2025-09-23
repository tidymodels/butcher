#' Axing a polr.
#'
#' polr objects are created from the \pkg{MASS} package, leveraged to
#' carry out ordered factor response analysis.
#'
#' @inheritParams butcher
#'
#' @return Axed polr object.
#'
#' #' @examplesIf rlang::is_installed("MASS")
#' library(MASS)
#'
#' # Add some large object to the environment
#' boop <- runif(1e6)
#'
#' polr_fit <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
#'
#' polr_fit_b <- butcher(polr_fit)
#'
#' weigh(polr_fit)
#' weigh(polr_fit_b)
#'
#' @name axe-polr
NULL


#' Remove environments.
#'
#' @rdname axe-polr
#' @export
axe_env.polr <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    add_class = TRUE,
    verbose = verbose
  )
}

