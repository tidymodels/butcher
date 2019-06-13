#' Weigh the object.
#'
#' Evaluate the size of each element contained in a model object.
#'
#' @param x model object
#' @param threshold cutoff memory level
#' @param units defaults to MB
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @return tibble
#' @export
#' @examples
#' simulate_x <- matrix(runif(1e+6), ncol = 2)
#' simulate_y <- runif(dim(simulate_x)[1])
#' lm_out <- lm(simulate_y ~ simulate_x)
#' weigh(lm_out)
weigh <- function(x, threshold = 2, units = "MB") {
  # TODO: examine str to replace use of rapply
  # TODO: edit this to weigh for s4 objects too
  # TODO: weigh for keras object
  # TODO: recursive function to check for an object location..
  stopifnot(is.list(x))

  units <- rlang::arg_match(units, c("KB", "MB", "GB"))
  if(units == "MB") {
    denom <- 1e+6
  } else if(units == "KB") {
    denom <- 1e+3
  } else {
    denom <- 1e+9
  }

  object_weights <- unlist(rapply(x, lobstr::obj_size))
  object_weights <- purrr::map(object_weights, as.numeric)
  # OR use rlang::squash here?

  dplyr::tibble(
    object = names(object_weights),
    size = unname(as.numeric(object_weights))/denom
  ) %>%
    dplyr::arrange(dplyr::desc(.data$size)) %>%
    dplyr::filter(.data$size > threshold)
}
