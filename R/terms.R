#' Axing for terms inputs.
#'
#' Generics related to axing objects of the term class.
#'
#' @inheritParams butcher
#'
#' @return Axed terms object.
#'
#' @examples
#' suppressWarnings(library(lobstr))
#'
#' # Using lm
#' wrapped_lm <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- lm(mpg ~ ., data = mtcars)
#'   return(fit)
#' }
#'
#' # Check object size
#' lobstr::obj_size(wrapped_lm())
#'
#' # Remove junk
#' cleaned_lm <- axe_env(wrapped_lm(), verbose = TRUE)
#'
#' # Check size again
#' lobstr::obj_size(cleaned_lm)
#'
#' # Compare environment in terms component
#' lobstr::obj_size(attr(wrapped_lm()$terms, ".Environment"))
#' lobstr::obj_size(attr(cleaned_lm$terms, ".Environment"))
#'
#' \donttest{
#' # Using rpart
#' suppressWarnings(library(rpart))
#'
#' wrapped_rpart <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- rpart(Kyphosis ~ Age + Number + Start,
#'                data = kyphosis,
#'                x = TRUE,
#'                y = TRUE)
#'   return(fit)
#' }
#'
#' lobstr::obj_size(wrapped_rpart())
#' lobstr::obj_size(axe_env(wrapped_rpart()))
#' }
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
