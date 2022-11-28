#' Axing an lm.
#'
#' lm objects are created from the base \pkg{stats} package.
#'
#' @inheritParams butcher
#'
#' @return Axed lm object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "rsample"))
#' # Load libraries
#' library(parsnip)
#' library(rsample)
#'
#' # Load data
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' lm_fit <- linear_reg() %>%
#'   set_engine("lm") %>%
#'   fit(mpg ~ ., data = car_train)
#'
#' out <- butcher(lm_fit, verbose = TRUE)
#'
#' # Another lm object
#' wrapped_lm <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- lm(mpg ~ ., data = mtcars)
#'   return(fit)
#' }
#'
#' # Remove junk
#' cleaned_lm <- axe_env(wrapped_lm(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_lm)
#'
#' # Compare environment in terms component
#' lobstr::obj_size(attr(wrapped_lm()$terms, ".Environment"))
#' lobstr::obj_size(attr(cleaned_lm$terms, ".Environment"))
#'
#' @name axe-lm
NULL

#' Remove the call.
#'
#' @rdname axe-lm
#' @export
axe_call.lm <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"), "offset", old)

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove the environment. The same environment is referenced in terms
#' as well as model attribute, both need to be addressed in order for
#' the environment to be completely replaced.
#'
#' @rdname axe-lm
#' @export
axe_env.lm <- function(x, verbose = FALSE, ...) {
  old <- x
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
#' @rdname axe-lm
#' @export
axe_fitted.lm <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", numeric(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("fitted()", "summary()"),
    verbose = verbose
  )
}

