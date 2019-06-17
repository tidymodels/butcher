#' Get path to model object example.
#'
#' butcher comes bundled with some example files in its `inst/extdata`
#' directory. This function was copied from readxl and placed here to
#' make the instantiated model objects easy to access.
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
#' @examples
#' butcher_example()
#' butcher_example("lm.rda")
butcher_example <- function(path = NULL) {
  if (is.null(path)) {
    output_path <- dir(system.file("extdata", package = "butcher"))
  } else {
    output_path <- system.file("extdata", path, package = "butcher", mustWork = TRUE)
    r_path <- paste0(unlist(strsplit(path, ".rda")), ".R")
    cat(readChar(system.file("inst/extdata-scripts", r_path, package = "butcher", mustWork = TRUE), 1e5))
  }
}
