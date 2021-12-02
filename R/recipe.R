#' Axing a recipe object.
#'
#' recipe objects are created from the \pkg{recipes} package, which is
#' leveraged for its set of data pre-processing tools. These recipes work
#' by sequentially defining each pre-processing step. The implementation
#' of each step, however, results its own class so we bundle all the axe
#' methods related to recipe objects in general here. Note that the
#' butchered class is only added to the recipe as a whole, and not to each
#' pre-processing step.
#'
#' @inheritParams butcher
#'
#' @return Axed recipe object.
#'
#' @examples
#' suppressPackageStartupMessages(library(recipes))
#' library(modeldata)
#'
#' data(biomass)
#'
#' biomass_tr <- biomass[biomass$dataset == "Training",]
#' rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
#'               data = biomass_tr) %>%
#'   step_center(all_predictors()) %>%
#'   step_scale(all_predictors()) %>%
#'   step_spatialsign(all_predictors())
#'
#' out <- butcher(rec, verbose = TRUE)
#'
#' # Another recipe object
#' wrapped_recipes <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   return(
#'     recipe(mpg ~ cyl, data = mtcars) %>%
#'       step_center(all_predictors()) %>%
#'       step_scale(all_predictors()) %>%
#'       prep()
#'   )
#' }
#'
#' # Remove junk in environment
#' cleaned1 <- axe_env(wrapped_recipes(), verbose = TRUE)
#' # Replace prepared training data with zero-row slice
#' cleaned2 <- axe_fitted(wrapped_recipes(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned1)
#' lobstr::obj_size(cleaned2)
#'
#' @name axe-recipe
NULL

#' A means to replace environments within each step of the recipe.
#'
#' @rdname axe-recipe
#' @export
axe_env.recipe <- function(x, verbose = FALSE, ...) {
  old <- x
  x$steps <- purrr::map(x$steps, function(z) axe_env(z, ...))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' No environment to axe in step object. Examples of such objects
#' include \code{step_sample}, \code{step_intercept}, and
#' \code{step_profile}.
#'
#' @rdname axe-recipe
#' @export
axe_env.step <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_arrange} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_arrange <- function(x, ...) {
  x$inputs <- purrr::map(x$inputs, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_filter} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_filter <- function(x, ...) {
  axe_env.step_arrange(x, ...)
}

#' A means to replace environments wrapped from the \code{step_mutate} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_mutate <- function(x, ...) {
  axe_env.step_arrange(x, ...)
}

#' A means to replace environments wrapped from the \code{step_slice} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_slice <- function(x, ...) {
  axe_env.step_arrange(x, ...)
}

#' A means to replace environments wrapped from the \code{step_impute_bag} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_impute_bag <- function(x, ...) {
  x <- NextMethod()
  x$impute_with <- purrr::map(x$impute_with, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_bagimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_bagimpute <- function(x, ...) {
  # Renamed to `step_impute_bag()` in recipes 0.1.16
  axe_env.step_impute_bag(x, ...)
}

#' A means to replace environments wrapped from the \code{step_impute_knn} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_impute_knn <- function(x, ...) {
  x <- NextMethod()
  x$impute_with <- purrr::map(x$impute_with, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_knnimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_knnimpute <- function(x, ...) {
  # Renamed to `step_impute_knn()` in recipes 0.1.16
  axe_env.step_impute_knn(x, ...)
}

#' A means to replace environments wrapped from the \code{step_geodist} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_geodist <- function(x, ...) {
  x$lat <- purrr::map(x$lat, function(z) axe_env(z, ...))
  x$lon <- purrr::map(x$lon, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_interact} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_interact <- function(x, ...) {
  attr(x$terms, ".Environment") <- rlang::base_env()
  x
}

#' A means to replace environments wrapped from the \code{step_ratio} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_ratio <- function(x, ...) {
  x <- NextMethod()
  x$denom <- purrr::map(x$denom, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped by quosures.
#'
#' @rdname axe-recipe
#' @export
axe_env.quosure <- function(x, ...) {
  attr(x, ".Environment") <- rlang::base_env()
  x
}

#' Remove fitted values
#'
#' @rdname axe-recipe
#' @export
axe_fitted.recipe <- function(x, verbose = FALSE, ...) {
  old <- x
  x$template <- vctrs::vec_ptype(x$template)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
