#' Get path to model object example.
#'
#' butcher comes bundled with some example files in its `inst/extdata`
#' directory. This function was copied from readxl and placed here to
#' make the instantiated model objects easy to access.
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
butcher_example <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "butcher"))
  } else {
    system.file("extdata", path, package = "butcher", mustWork = TRUE)
  }
}
