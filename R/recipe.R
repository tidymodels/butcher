#' Axing a recipe object.
#'
#' This is where all the recipe specific documentation lies.
#'
#'
#' @name axe-recipe
NULL

#' A means to replace environments within each step of the recipe.
#'
#' @rdname axe-recipe
#' @export
axe_env.recipe <- function(x, ...) {
  num_steps <- length(x$steps)
  for(i in 1:num_steps) {
    num_terms <- length(x$steps[[i]]$terms)
    for(j in 1:num_terms) {
      attr(x$steps[[i]]$terms[[j]], ".Environment") <- rlang::base_env()
    }
  }
  x
}
