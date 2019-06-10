#' Carve selection from model object.
#'
#' @param x model object
carve <- function(x, ...) {
  UseMethod("carve")
}

#' @export
carve.lm <- function(x, ...) {
  stopifnot(inherits(x, "lm"))
  keep_parts <- rlang::ensyms(...)
  keep_parts <- unname(unlist(purrr::map(keep_parts, rlang::as_string)))
  keep_parts <- c(keep_parts, "coefficients", "rank", "fitted.values", "qr", "terms", "model")
  # Check these parts exist
  inventory <- take_inventory(x)
  # Remove undesired inventory
  undesired_inventory <- inventory$overall[!inventory$overall %in% keep_parts]
  x[undesired_inventory] <- NULL
  # Remove undesired environment
  x_carved <- remove_env(inventory$all_attributes)

}



