#' Axing for terms inputs.
#'
#' Generics related to axing objects of the term class.
#'
#' @param x Terms object.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed terms object.
#'
#' @name axe-terms
NULL

#' @rdname axe-terms
#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::base_env()
  x
}
