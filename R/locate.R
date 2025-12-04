#' Locate part of an object.
#'
#' Locate where a specific component of a object might exist within
#' the model object itself. This function is restricted in that only
#' items that can be axed can be found.
#'
#' @param x A model object.
#' @param name A name associated with model component of interest.
#'   This defaults to NULL. Possible components include: \code{env},
#'   \code{call}, \code{data}, \code{ctrl}, and \code{fitted}.
#'
#' @return Location of specific component in a model object.
#' @examples
#' lm_fit <- lm(mpg ~ ., data = mtcars)
#' locate(lm_fit, name = "env")
#' locate(lm_fit, name = "call")
#' @export
locate <- function(x, name = NULL) {
  if (is.null(name)) {
    stop("No specific model component specified!")
  } else {
    item <- rlang::arg_match(name, c("env", "call", "data", "ctrl", "fitted"))
  }
  if (item == "env") {
    loc <- butcher_unlist(butcher_map(x, find_environment), c)
    parsed_loc <- names(loc)[loc]
  } else if (item == "fitted") {
    loc <- butcher_unlist(butcher_map(x, is.numeric), c)
    locs <- grep("fitt", names(loc))
    locs <- c(locs, grep("residuals", names(loc)))
    parsed_loc <- names(loc)[locs]
  } else if (item == "ctrl") {
    loc <- butcher_unlist(butcher_map(x, is.numeric), c)
    locs <- grep("control", names(loc))
    parsed_loc <- names(loc)[locs]
  } else if (item == "data") {
    loc <- butcher_unlist(butcher_map(x, is.numeric), c)
    locs <- grep("data", names(loc))
    parsed_loc <- names(loc)[locs]
  } else if (item == "call") {
    loc <- butcher_unlist(butcher_map(x, rlang::is_call), c)
    locs <- grep("call", names(loc))
    parsed_loc <- names(loc)[locs]
  } else {
    stop("Not valid item requested.")
  }

  if (length(parsed_loc) > 0) {
    return(paste0("x$", parsed_loc))
  } else {
    stop("Sorry, this part of the model object was not located.")
  }
}

butcher_map <- function(.x, .f, ...) {
  if (rlang::is_list(.x)) {
    purrr::map(.x, butcher_map, .f, ...)
  } else {
    .f <- purrr::as_mapper(.f, ...)
    .f(.x, ...)
  }
}

butcher_unlist <- function(.x, .f, ...) {
  .f <- purrr::as_mapper(.f)
  is_sublist <- purrr::map_lgl(.x, rlang::is_list)
  .x[is_sublist] <- purrr::map(.x[is_sublist], butcher_unlist, .f, ...)
  rlang::exec(.f, !!!.x, ...)
}

find_environment <- function(x) {
  temp <- attributes(x)
  if (rlang::is_bare_list(temp)) {
    return(any(purrr::map_lgl(temp, rlang::is_environment)))
  }
}
