#' Axing formulas.
#'
#' formulas might capture an environment from the modeling development
#' process that carries objects that will not be used for any post-
#' estimation activities.
#'
#' @inheritParams butcher
#'
#' @return Axed formula object.
#'
#' @examples
#' wrapped_formula <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   ex <- as.formula(paste("y ~", paste(LETTERS, collapse = "+")))
#'   return(ex)
#' }
#'
#' lobstr::obj_size(wrapped_formula())
#' lobstr::obj_size(butcher(wrapped_formula()))
#'
#' wrapped_quosure <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   out <- rlang::quo(x)
#'   return(out)
#' }
#' lobstr::obj_size(wrapped_quosure())
#' lobstr::obj_size(butcher(wrapped_quosure))
#'
#' @name axe-formula
NULL

#' Remove the environment.
#'
#' @rdname axe-formula
#' @export
axe_env.formula <- function(x, verbose = FALSE, ...) {
  old <- x
  attr(x, ".Environment") <- rlang::base_env()

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
