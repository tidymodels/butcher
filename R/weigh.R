#' Weigh the object.
#'
#' Evaluate the size of each element contained in a model object.
#'
#' @param x model object
#' @param ... any additional arguments related to weighing
#'
#' @return tibble
#' @examples
#' simulate_x <- matrix(runif(1e+6), ncol = 2)
#' simulate_y <- runif(dim(simulate_x)[1])
#' lm_out <- lm(simulate_y ~ simulate_x)
#' weigh(lm_out)
#' @export
weigh <- function(x, ...) {
  UseMethod("weigh")
}

#' @export
weigh.default <- function(x, threshold = 2, units = "MB") {
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
  output_table <- tibble::tibble(
    object = names(object_weights),
    size = unname(as.numeric(object_weights))/denom
  )
  # Sort
  output_table <- output_table[order(output_table$size, decreasing = TRUE), ]
  # Filter
  output_table <- output_table[output_table$size >= threshold, ]
  return(output_table)
}

#' @export
weigh.stanreg <- function(x, ...) {
  # Stanreg objects require a separate weigh function to handle S4
  stopifnot(class(x$stanfit) == "stanfit")
  # Get the object sizes associated with first hierarchy
  toplevel_weights <- weigh.default(x, ...)
  # Now get the object sizes associated with S4 object
  coerce_to_list <- function(z) {
    out <- list()
    for(i in slotNames(z)) out[[i]] <- slot(z, i)
    return(out)
  }
  stanfit_x <- coerce_to_list(x$stanfit)
  sublevel_weights <- weigh.default(stanfit_x, ...)
  # Combine these results for one tibble
  sublevel_weights$object <- paste0("stanfit.", sublevel_weights$object)
  # Bind together
  output_table <- rbind(toplevel_weights, sublevel_weights)
  # Sort
  output_table <- output_table[order(output_table$size, decreasing = TRUE), ]
  return(output_table)
}

#' @export
weigh.model_fit <- function(x, ...) {
  weigh(x$fit, ...)
}
