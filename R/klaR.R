#' Axing an rda.
#'
#' rda objects are created from the \pkg{klaR} package, leveraged to
#' carry out regularized discriminant analysis.
#'
#' @inheritParams butcher
#'
#' @return Axed rda object.
#'
#' @examplesIf rlang::is_installed("klaR")
#' library(klaR)
#'
#' fit_mod <- function() {
#'   boop <- runif(1e6)
#'   rda(
#'     y ~ x,
#'     data = data.frame(y = rep(letters[1:4], 1e4), x = rnorm(4e4)),
#'     gamma = 0.05,
#'     lambda = 0.2
#'   )
#' }
#'
#' mod_fit <- fit_mod()
#' mod_res <- butcher(mod_fit)
#'
#' weigh(mod_fit)
#' weigh(mod_res)
#'
#'
#' @name axe-rda
#' @aliases axe-klaR
NULL

#' @rdname axe-rda
#' @export
axe_call.rda <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    #disabled = c("print()", "summary()", "update()"),
    verbose = verbose
  )
}

#' @rdname axe-rda
#' @export
axe_env.rda <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}


#' Axing a NaiveBayes.
#'
#' NaiveBayes objects are created from the \pkg{klaR} package, leveraged to
#' fit a Naive Bayes Classifier.
#'
#' @inheritParams butcher
#'
#' @return Axed NaiveBayes object.
#'
#' @examplesIf rlang::is_installed("klaR")
#' library(klaR)
#'
#' fit_mod <- function() {
#'   boop <- runif(1e6)
#'   NaiveBayes(
#'     y ~ x,
#'     data = data.frame(y = as.factor(rep(letters[1:4], 1e4)), x = rnorm(4e4))
#'   )
#' }
#'
#' mod_fit <- fit_mod()
#' mod_res <- butcher(mod_fit)
#'
#' weigh(mod_fit)
#' weigh(mod_res)
#'
#'
#' @name axe-NaiveBayes
NULL

#' @rdname axe-NaiveBayes
#' @export
axe_call.NaiveBayes <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    #disabled = c("print()", "summary()", "update()"),
    verbose = verbose
  )
}

#' @rdname axe-NaiveBayes
#' @export
axe_data.NaiveBayes <- function(x, verbose = FALSE, ...) {
  old <- x
  x$x <- data.frame()

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
