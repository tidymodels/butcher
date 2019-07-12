#' Weigh the object.
#'
#' Evaluate the size of each element contained in a model object.
#'
#' @param x model object
#' @param ... additional arguments for weighing
#'
#' @return tibble with weights of object components in decreasing magnitude
#'
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
weigh.default <- function(x, threshold = 0, units = "MB", ...) {
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
  out <- list()
  for(i in methods::slotNames(x$stanfit)) {
    out[[i]] <- methods::slot(x$stanfit, i)
  }
  x$stanfit <- out
  class(x) <- class(x)[2]
  weigh(x, ...)
}

#' @export
weigh.ksvm <- function(x, ...) {
  out <- list()
  for(i in methods::slotNames(x)) {
    out[[i]] <- methods::slot(x, i)
  }
  weigh(out, ...)
}

#' @export
weigh.model_fit <- function(x, ...) {
  weigh(x$fit, ...)
}
