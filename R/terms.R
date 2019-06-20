#' Axing for terms inputs.
#'
#' Generics related to axing objects of the term class.
#'
#' @param x model object
#' @param ... any additional arguments related to axing
#'
#' @return axed model object
#'
#' @name axe-terms
NULL

#' @rdname axe-terms
#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::base_env()
  x
}
