
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
add_butcher_attributes <- function(x, old, disabled = NULL, add_class = TRUE, verbose = TRUE) {
  x <- add_butcher_disabled(x, disabled)
  if (add_class) {
    x <- add_butcher_class(x)
  }
  if (verbose & !missing(old)) {
    assess_object(old, x)
  }
  x
}

# from usethis
slug <- function(x, ext) {
  x_base <- fs::path_ext_remove(x)
  x_ext <- fs::path_ext(x)
  ext <- if (identical(tolower(x_ext), tolower(ext))) x_ext else ext
  fs::path_ext_set(x_base, ext)
}
