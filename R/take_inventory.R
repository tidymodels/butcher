#' Take inventory.
#'
#' List all the components of a model object to prepare for processing.
#'
#' @param x model object
#'
#' @return itemized parts of model object
#' @export
take_inventory <- function(x, ...) {
  UseMethod("take_inventory")
}

#' @export
take_inventory.default <- function(x, ...) {
  list(overall = names(x),
       all_attributes = rapply(x, attributes))
}

#' @export
take_inventory.lm <- function(x, ...) {
  stopifnot(inherits(x, "lm"))
  take_inventory.default(x, ...)
}
