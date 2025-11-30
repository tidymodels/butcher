
# check existence
exchange <- function(x, component, replacement, addition = NULL, old) {
  out <- purrr::pluck(x, component, .default = NULL)
  if (!rlang::is_null(out)) {
    x[[component]] <- replacement
    if (!is.null(addition) & !missing(old)) {
      if (!is.null(old[[component]][[addition]])) {
        x[[component]][[addition]] <- old[[component]][[addition]]
      }
    }
  }
  x
}

# butcher attributes helper
add_butcher_disabled <- function(x, disabled = NULL) {
  current <- attr(x, "butcher_disabled")
  if(!is.null(disabled)) {
    disabled <- union(current, disabled)
    attr(x, "butcher_disabled") <- disabled
  }
  x
}

# class assignment helper
add_butcher_class <- function(x) {
  if(!any(grepl("butcher", class(x)))) {
    class(x) <- append(paste0("butchered_", class(x)[1]), class(x))
  }
  x
}

# butcher attributes wrapper
add_butcher_attributes <- function(x, old, disabled = NULL, add_class = TRUE, verbose = FALSE) {
  if (!identical(x, old)) {
    x <- add_butcher_disabled(x, disabled)
    if (add_class) {
      x <- add_butcher_class(x)
    }
  }
  if (verbose & !missing(old)) {
    assess_object(old, x)
  }
  x
}

# adapted from ps:::is_cran_check()
# nocov start

is_cran_check <- function () {
  if (identical(Sys.getenv("NOT_CRAN"), "true")) {
    FALSE
  } else {
    Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != ""
  }
}

#nocov end
