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
#' test <- function() {
#'   x <- runif(10e4)
#'   ex <- as.formula(paste("y ~", paste(LETTERS, collapse = "+")))
#'   return(ex)
#' }
#' out <- test()
#' axed_out <- axe_env(out)
#' @name axe-formula
NULL

#' Remove the environment.
#'
#' @rdname axe-formula
#' @export
axe_env.formula <- function(x, verbose = FALSE, ...) {
  old <- x
  attr(x, ".Environment") <- rlang::empty_env()

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
