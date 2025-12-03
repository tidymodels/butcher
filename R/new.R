#' New axe functions for a modeling object.
#'
#' @description
#'
#' \code{new_model_butcher()} will instantiate the following to help
#'   us develop new axe functions around removing parts of a new
#'   modeling object:
#' \itemize{
#'   \item Add modeling package to \code{Suggests}
#'   \item Generate and populate an axe file under \code{R/}
#'   \item Generate and populate an test file under \code{testthat/}
#' }
#'
#' @param model_class A string that captures the class name of
#'   the new model object.
#' @param package_name A string that captures the package name
#'   from which the new model is made.
#' @param open Check if user is in interactive mode, and if so,
#'   opens the new files for editing.
#' @param call The execution environment of a currently running function, e.g.
#'   `caller_env()`. The function will be mentioned in error messages as the
#'   source of the error.
#'
#' @export
new_model_butcher <- function(
  model_class,
  package_name,
  open = interactive(),
  call = rlang::caller_env()
) {
  rlang::check_installed("fs", reason = "to create new axe functions.")
  rlang::check_installed("usethis", reason = "to create new axe functions.")

  if (!rlang::is_string(model_class) | !rlang::is_string(package_name)) {
    cli::cli_abort("{.arg {model_class}} must be a string.", call = call)
  }
  if (grepl("\\s", model_class) | grepl("\\s", package_name)) {
    cli::cli_abort("{.arg {model_class}} cannot have any spaces.", call = call)
  }
  package_exists <- find.package(package_name, quiet = TRUE)
  if (length(package_exists) == 0) {
    cli::cli_abort(
      "{.arg {package_name}} referenced is not installed.",
      call = call
    )
  }

  usethis::use_package(package_name, type = "Suggests")
  usethis::ui_line("")

  first <- substring(model_class, 1, 1)
  if (is.element(first, c("a", "e", "i", "o", "u"))) {
    article <- "an"
  } else {
    article <- "a"
  }

  data <- list(
    model_class = model_class,
    package_name = package_name,
    article = article
  )

  filename <- slug({{ model_class }}, ".R")
  r_path <- fs::path("R", filename)
  test_path <- fs::path("tests", "testthat", paste0("test-", filename))

  usethis::ui_info("Writing skeleton files")
  usethis::use_template(
    "butcher_object.R",
    save_as = r_path,
    data = data,
    package = "butcher"
  )
  usethis::use_template(
    "test-butchered_object.R",
    save_as = test_path,
    data = data,
    package = "butcher"
  )

  if (
    fs::file_exists(usethis::proj_path(r_path)) &
      fs::file_exists(usethis::proj_path(test_path))
  ) {
    if (open) {
      usethis::edit_file(usethis::proj_path(r_path))
      usethis::edit_file(usethis::proj_path(test_path))
    }
  }

  usethis::ui_line("")
  invisible(model_class)
}

# From usethis
slug <- function(x, ext) {
  x_base <- fs::path_ext_remove(x)
  x_ext <- fs::path_ext(x)
  ext <- if (identical(tolower(x_ext), tolower(ext))) x_ext else ext
  fs::path_ext_set(x_base, ext)
}
