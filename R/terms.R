#' Axing for terms inputs.
#'
#' Generics related to axing objects of the term class.
#'
#' @inheritParams butcher
#'
#' @return Axed terms object.
#'
#' @examples
#' fit <- lm(Species ~ ., data = iris)
#' butcher(fit$terms)
#'
#' @name axe-terms
NULL

#' @rdname axe-terms
#' @export
axe_env.terms <- function(x, verbose = FALSE, ...) {
  old <- x
  attr(x, ".Environment") <- rlang::base_env()

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
