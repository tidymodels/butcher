#' Axing a train.recipe object.
#'
#' train.recipe objects are slightly different from train objects
#' created from the \code{caret} package in that it also includes
#' instructions from a \code{recipe} for data pre-processing. Axing
#' functions specific to train.recipe are thus included as additional
#' steps are required to remove parts of train.recipe objects.
#'
#' @inheritParams butcher
#'
#' @return Axed train.recipe object.
#'
#' @examplesIf interactive() || identical(Sys.getenv("IN_PKGDOWN"), "true")
#' library(recipes)
#' library(caret)
#' data(biomass, package = "modeldata")
#'
#' data(biomass)
#' recipe <- biomass |>
#'   recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur) |>
#'   step_center(all_predictors()) |>
#'   step_scale(all_predictors()) |>
#'   step_spatialsign(all_predictors())
#'
#' train.recipe_fit <- train(recipe, biomass,
#'                           method = "svmRadial",
#'                           metric = "RMSE")
#'
#' out <- butcher(train.recipe_fit, verbose = TRUE)
#' @name axe-train.recipe
NULL

#' Remove the call. Additional call parameters are stored under
#' \code{dots} in the model object and should also be removed for
#' consistency.
#'
#' @rdname axe-train.recipe
#' @export
axe_call.train.recipe <- function(x, ...) {
  x$call <- call("dummy_call")
  x$dots <- list(NULL)
  add_butcher_class(x)
}

#' Remove controls. For a train.recipe object, an environment is
#' stored under \code{attr(attributes(x$control$summaryFunction)$srcref, "srcfile")}
#' and thus will also be removed.
#'
#' @rdname axe-train.recipe
#' @export
axe_ctrl.train.recipe <- function(x, ...) {
  x$control <- list(NULL)
  add_butcher_class(x)
}

#' Remove training data.
#'
#' @rdname axe-train.recipe
#' @export
axe_data.train.recipe <- function(x, ...) {
  x$trainingData <- data.frame(NA)
  add_butcher_class(x)
}

#' Remove environments. Model objects of this type include references to
#' environments in each step of the recipe, and thus must also be
#' removed. Note that environments that result from \code{srcref} are
#' not axed.
#'
#' @rdname axe-train.recipe
#' @export
axe_env.train.recipe <- function(x, ...) {
  x$recipe <- axe_env(x$recipe, ...)
  x$modelInfo <- purrr::map(x$modelInfo, function(z) axe_env(z, ...))
  add_butcher_class(x)
}

#' Remove fitted values stored in \code{pred}. Outcome values are numeric
#' for regression and character for classification. If the model object
#' was created under classification, there is a second argument level that
#' stores the outcome factor levels and could also removed for consistency.
#'
#' @rdname axe-train.recipe
#' @export
axe_fitted.train.recipe <- function(x, ...) {
  x$pred <- list(NULL)
  add_butcher_class(x)
}
