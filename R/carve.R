#' Carve selection from model object.
#'
#' @param x model object
#'
#' @export
carve <- function(x, ...) {
  UseMethod("carve")
}


#' @export
carve.lm <- function(x, ...) {
  stopifnot(inherits(x, "lm"))
  keep_parts <- rlang::ensyms(...)
  keep_parts <- unname(unlist(purrr::map(keep_parts, rlang::as_string)))
  # Check these parts exist
  inventory <- take_inventory(x)
  # Remove undesired inventory
  undesired_inventory <- inventory$overall[!inventory$overall %in% keep_parts]
  x[undesired_inventory] <- NULL
  return(x)
}

#' @export
carve.model_fit <- function(x, ...) {
  if(!inherits(x, "model_fit")){
    stop("Not a parsnip model object.")
  }
  carve(x$fit, ...)
}
