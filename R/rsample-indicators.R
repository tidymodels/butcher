#' @rdname axe-rsample-indicators
#' @export
axe_rsample_indicators.rsplit <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- zero_all_ind(x)
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

#' @rdname axe-rsample-indicators
#' @export
axe_rsample_indicators.three_way_split <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- zero_all_ind(x)
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

#' @rdname axe-rsample-indicators
#' @export
axe_rsample_indicators.rset <- function(x, verbose = FALSE, ...) {
  old <- x

  if (any(names(x) == "splits")) {
    x$splits <- purrr::map(x$splits, axe_rsample_indicators)
  }

  add_butcher_attributes(
    x,
    old,
    disabled = c("populate()", "reverse_splits()", "tidy()"),
    verbose = verbose
  )
}


#' @rdname axe-rsample-indicators
#' @export
axe_rsample_indicators.tune_results <- function(x, verbose = FALSE, ...) {
  old <- x
  if (any(names(x) == "splits")) {
    x$splits <- purrr::map(x$splits, axe_rsample_indicators)
  }
  add_butcher_attributes(
    x,
    old,
    disabled = c("augment()", "fit_best()"),
    verbose = verbose
  )
}


#' @rdname axe-rsample-indicators
#' @export
axe_rsample_indicators.workflow_set <- function(x, verbose = FALSE, ...) {
  has_res <- purrr::map_lgl(x$result, ~ inherits(.x, "tune_results"))
  if (!any(has_res)) {
    return(x)
  }

  old <- x

  for (i in which(has_res)) {
    x$result[[i]] <- axe_rsample_indicators(x$result[[i]])
  }

  add_butcher_attributes(
    x,
    old,
    disabled = c("augment()", "fit_best()"),
    verbose = verbose
  )
}

# ------------------------------------------------------------------------------

zero_ind <- function(ind) {
  if (!all(is.na(ind))) {
    ind <- integer(0)
  }
  ind
}

zero_all_ind <- function(split) {
  ind_nms <- grep("_id$", names(split), value = TRUE)
  for (nm in ind_nms) {
    split[[nm]] <- zero_ind(split[[nm]])
  }
  split
}
