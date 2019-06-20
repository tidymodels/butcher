#' Axing for terms inputs.
#'
#' These terms axe functions treat the model object as if
#' nothing needs to be done.
#'
#' @name axe-terms
NULL

#' @rdname axe-terms
#' @export
axe_env.terms <- function(x, ...) {
  attr(x, ".Environment") <- rlang::base_env()
  x
}
