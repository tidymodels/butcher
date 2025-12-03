#' Weigh the object.
#'
#' Evaluate the size of each element contained in a model object.
#'
#' @param x A model object.
#' @param threshold The minimum threshold desired for model component
#'   size to display.
#' @param units The units in which to display the size of each component
#'   within the model object of interest. Defaults to \code{MB}. Other
#'   options include \code{KB} and \code{GB}.
#' @param ... Any additional arguments for weighing.
#'
#' @return Tibble with weights of object components in decreasing magnitude.
#'
#' @examples
#' simulate_x <- matrix(runif(1e+6), ncol = 2)
#' simulate_y <- runif(dim(simulate_x)[1])
#' lm_out <- lm(simulate_y ~ simulate_x)
#' weigh(lm_out)
#' @export
weigh <- function(x, threshold = 0, units = "MB", ...) {
  UseMethod("weigh")
}

#' @export
weigh.default <- function(x, threshold = 0, units = "MB", ...) {
  stopifnot(is.list(x))
  units <- rlang::arg_match(units, c("KB", "MB", "GB"))
  if (units == "MB") {
    denom <- 1e+6
  } else if (units == "KB") {
    denom <- 1e+3
  } else {
    denom <- 1e+9
  }
  object_weights <- unlist(rapply(x, get_object_size))
  object_weights <- purrr::map(object_weights, as.numeric)
  output_table <- tibble::tibble(
    object = names(object_weights),
    size = unname(as.numeric(object_weights)) / denom
  )
  # Sort
  output_table <- output_table[order(output_table$size, decreasing = TRUE), ]
  # Filter
  output_table <- output_table[output_table$size >= threshold, ]
  return(output_table)
}

#' @export
weigh.ksvm <- function(x, threshold = 0, units = "MB", ...) {
  out <- list()
  for (i in methods::slotNames(x)) {
    out[[i]] <- methods::slot(x, i)
  }
  weigh(out, ...)
}

#' @export
weigh.model_fit <- function(x, threshold = 0, units = "MB", ...) {
  weigh(x$fit, ...)
}


get_object_size <- function(x, attempts = 5) {
  for (i in seq_len(attempts)) {
    res <- try(lobstr::obj_size(x), silent = TRUE)
    if (!inherits(res, "try-error")) {
      break()
    }
  }
  if (inherits(res, "try-error")) {
    cli::cli_inform(
      "{.fn lobstr::obj_size} failed after {attempts} attempts. Falling back on {.fn object.size}."
    )
    res <- utils::object.size(x)
  }

  res
}
