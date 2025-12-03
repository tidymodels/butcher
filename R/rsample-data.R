#' @rdname axe-rsample-data
#' @export
axe_rsample_data.rsplit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- zero_data(x)
  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "analysis()",
      "as.data.frame()",
      "as.integer()",
      "assessment()",
      "complement()",
      "internal_calibration_split()",
      "populate()",
      "reverse_splits()",
      "testing()",
      "tidy()",
      "training()"
    ),
    verbose = verbose
  )
}

#' @rdname axe-rsample-data
#' @export
axe_rsample_data.three_way_split <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- zero_data(x)
  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "internal_calibration_split()",
      "testing()",
      "training()",
      "validation()"
    ),
    verbose = verbose
  )
}

#' @rdname axe-rsample-data
#' @export
axe_rsample_data.rset <- function(x, verbose = FALSE, ...) {
  old <- x

  if (any(names(x) == "splits")) {
    x$splits <- purrr::map(x$splits, axe_rsample_data)
  }

  add_butcher_attributes(
    x,
    old,
    disabled = c("populate()", "reverse_splits()", "tidy()"),
    verbose = verbose
  )
}

#' @rdname axe-rsample-data
#' @export
axe_rsample_data.tune_results <- function(x, verbose = FALSE, ...) {
  old <- x

  if (any(names(x) == "splits")) {
    x$splits <- purrr::map(x$splits, axe_rsample_data)
  }

  add_butcher_attributes(
    x,
    old,
    disabled = c("augment()", "fit_best()"),
    verbose = verbose
  )
}

#' @rdname axe-rsample-data
#' @export
axe_rsample_data.workflow_set <- function(x, verbose = FALSE, ...) {
  has_res <- purrr::map_lgl(x$result, ~ inherits(.x, "tune_results"))
  if (!any(has_res)) {
    return(x)
  }
  old <- x

  for (i in which(has_res)) {
    x$result[[i]] <- axe_rsample_data(x$result[[i]])
  }

  add_butcher_attributes(
    x,
    old,
    disabled = c("augment()", "fit_best()"),
    verbose = verbose
  )
}

# ------------------------------------------------------------------------------

zero_data <- function(split) {
  split$data <- split$data[0, , drop = FALSE]
  split
}
