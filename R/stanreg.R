#' Axing a stanreg.
#'
#' stanreg objects are created from the \pkg{rstanarm} package, leveraged
#' to do Bayesian regression modeling with \pkg{stan}.
#'
#' @inheritParams butcher
#'
#' @return Axed stanreg object.
#'
#' @examples
#' \donttest{
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rsample)))
#' suppressWarnings(suppressMessages(library(rstanarm)))
#'
#' # Load data
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' ctrl <- fit_control(verbosity = 0) # Avoid printing output
#' stanreg_fit <- linear_reg() %>%
#'   set_engine("stan") %>%
#'   fit(mpg ~ ., data = car_train, control = ctrl)
#'
#' out <- butcher(stanreg_fit, verbose = TRUE)
#'
#' # Another stanreg object
#' wells$dist100 <- wells$dist / 100
#' fit <- stan_glm(
#'   switch ~ dist100 + arsenic,
#'   data = wells,
#'   family = binomial(link = "logit"),
#'   prior_intercept = normal(0, 10),
#'   QR = TRUE,
#'   chains = 2,
#'   iter = 200 # for speed purposes only
#' )
#'
#' out <- butcher(fit, verbose = TRUE)
#' }
#' @name axe-stanreg
NULL

#' Remove the call.
#'
#' @rdname axe-stanreg
#' @export
axe_call.stanreg <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-stanreg
#' @export
axe_env.stanreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x$stanfit@.MISC <- rlang::empty_env()
  x$stanfit@stanmodel@dso@.CXXDSOMISC <- rlang::empty_env()
  x$terms <- axe_env(x$terms, ...)
  attributes(x$model)$terms <- axe_env(attributes(x$model)$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-stanreg
#' @export
axe_fitted.stanreg <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
