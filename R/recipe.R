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
#' suppressWarnings(suppressMessages(library(recipes)))
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
#'       step_scale(all_predictors())
#'   )
#' }
#'
#' # Remove junk
#' cleaned_recipes <- axe_env(wrapped_recipes(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_recipes)
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

#' A means to replace environments wrapped from the \code{step_bagimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_bagimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x$impute_with <- purrr::map(x$impute_with, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_bin2factor} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_bin2factor <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_BoxCox} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_BoxCox <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_bs} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_bs <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_center} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_center <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_classdist} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_classdist <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_corr} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_corr <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_count} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_count <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_date} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_date <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_depth} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_depth <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_discretize} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_discretize <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_downsample} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_downsample <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_dummy} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_dummy <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_factor2string} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_factor2string <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_filter} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_filter <- function(x, ...) {
  x$inputs <- purrr::map(x$inputs, function(z) axe_env(z, ...))
  x
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

#' A means to replace environments wrapped from the \code{step_holiday} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_holiday <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_hyperbolic} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_hyperbolic <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_ica} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_ica <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_integer} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_integer <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_interact} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_interact <- function(x, ...) {
  attr(x$terms, ".Environment") <- rlang::empty_env()
  x
}

#' A means to replace environments wrapped from the \code{step_inverse} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_inverse <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_invlogit} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_invlogit <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_isomap} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_isomap <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_knnimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_knnimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x$impute_with <- purrr::map(x$impute_with, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_kpca} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_kpca <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_lag} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_lag <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_lincomb} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_lincomb <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_log} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_log <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_logit} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_logit <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_lowerimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_lowerimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_meanimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_meanimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_medianimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_medianimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_modeimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_modeimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_mutate} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_mutate <- function(x, ...) {
  x$inputs <- purrr::map(x$inputs, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_naomit} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_naomit <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_nnmf} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_nnmf <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_novel} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_novel <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_num2factor} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_num2factor <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_ns} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_ns <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_nzv} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_nzv <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_ordinalscore} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_ordinalscore <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_other} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_other <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_pca} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_pca <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_pls} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_pls <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_poly} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_poly <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_range} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_range <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_ratio} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_ratio <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x$denom <- purrr::map(x$denom, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_regex} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_regex <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_relu} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_relu <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_rm} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_rm <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_rollimpute} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_rollimpute <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_shuffle} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_shuffle <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_slice} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_slice <- function(x, ...) {
  x$inputs <- purrr::map(x$inputs, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_scale} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_scale <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_string2factor} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_string2factor <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_sqrt} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_sqrt <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_spatialsign} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_spatialsign <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_unorder} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_unorder <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_upsample} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_upsample <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_window} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_window <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_YeoJohnson} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_YeoJohnson <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped from the \code{step_zv} function.
#'
#' @rdname axe-recipe
#' @export
axe_env.step_zv <- function(x, ...) {
  x$terms <- purrr::map(x$terms, function(z) axe_env(z, ...))
  x
}

#' A means to replace environments wrapped by quosures.
#'
#' @rdname axe-recipe
#' @export
axe_env.quosure <- function(x, ...) {
  attr(x, ".Environment") <- rlang::empty_env()
  x
}
