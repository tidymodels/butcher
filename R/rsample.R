#' Axing rsample objects
#'
#' sclass objects are byproducts of classbagg objects.
#'
#' @inheritParams butcher
#'
#' @return Axed rset object.
#' @name axe-rsample
NULL

#' @rdname axe-rsample
#' @export
axe_rsample_data <- function(x, verbose = FALSE, ...) {
  UseMethod("axe_rsample_data")
}

#' @rdname axe-rsample
#' @export
axe_rsample_data.default <- function(x, verbose = FALSE, ...) {
  old <- x
  if (verbose) {
    assess_object(old, x)
  }
  x
}

#' @rdname axe-rsample
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
    add_class = TRUE,
    verbose = verbose
  )
  x
}

#' @rdname axe-rsample
#' @export
axe_rsample_data.rset <- function(x, verbose = FALSE, ...) {
  old <- x
  if (any(names(x) == "splits")) {
    x$splits <- purrr::map(x$splits, axe_rsample_data)
  }
  add_butcher_attributes(
    x,
    old,
    disabled = c("populate()", "tidy()"),
    add_class = TRUE,
    verbose = verbose
  )
  x
}

#' @rdname axe-rsample
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
      "assessment()",
      "complement()",
      "dim()",
      "testing()",
      "training()",
      "tidy()"
    ),
    add_class = TRUE,
    verbose = verbose
  )
  x
}

#' @rdname axe-rsample
#' @export
axe_rsample_data.three_way_split <- axe_rsample_data.rsplit


# ------------------------------------------------------------------------------

zero_data <- function(split) {
  split$data <- split$data[0, , drop = FALSE]
  split
}
