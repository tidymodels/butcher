# These functions are copied from [https://github.com/r-lib/generics/blob/main/R/docs.R] for dynamic documentation.

# nocov start

methods_find <- function(x) {
  info <- attr(utils::methods(x), "info")

  if (nrow(info) == 0) {
    info$topic <- character()
    return(info)
  }

  info$method <- rownames(info)
  rownames(info) <- NULL

  if (getRversion() < "3.2") {
    info$isS4 <- grepl("-method$", info$method)
  }

  # Simply class and source
  generic_esc <- gsub("\\.", "\\\\.", x)
  info$class <- gsub(paste0("^", generic_esc, "[.,]"), "", info$method)
  info$class <- gsub("-method$", "", info$class)
  info$source <- gsub(paste0(" for ", generic_esc), "", info$from)

  # Find package
  info$package <- lookup_package(x, info$class, info$isS4)

  # Find help topic
  path <- help_path(info$method, info$package)
  pieces <- strsplit(path, "/")
  info$topic <- vapply(pieces, last, character(1))

  info[c("method", "class", "package", "topic", "visible", "source")]
}

methods_rd <- function(x) {
  methods <- methods_find(x)
  methods <- methods[!is.na(methods$topic), , drop = FALSE]

  if (nrow(methods) == 0) {
    return("No methods found in currently loaded packages.")
  }

  methods_by_package <- split(methods, methods$package)

  topics_by_package <- lapply(methods_by_package, function(x) {
    split(x, paste(x$topic, x$package, sep = "."))
  })

  make_bullets <- function(topics) {
    bullet_vec <- vapply(
      X = topics,
      FUN = function(x) {
        link <- paste0(
          "\\code{",
          "\\link[", x$package[[1]], "]",
          "{", x$topic[[1]], "}",
          "}"
        )
        classes <- paste0("\\code{", x$class, "}", collapse = ", ")
        paste0("\\item ", link, ": ", classes)
      },
      FUN.VALUE = character(1),
      USE.NAMES = FALSE
    )

    paste0(bullet_vec, collapse = "\n")
  }

  make_header <- function(pkg) {
    paste0("\\code{", pkg, "}")
  }

  bullets <- lapply(topics_by_package, make_bullets)
  headers <- lapply(names(topics_by_package), make_header)

  help_msg <- paste0(
    "See the following help topics for more details about individual methods:\n"
  )

  paste0(
    c(help_msg,
      paste(
        headers,
        "\\itemize{",
        bullets,
        "}",
        sep = "\n"
      )
    ),
    collapse = "\n"
  )

}

last <- function(x, n = 0) {
  if (length(x) <= n) {
    x[NA_integer_]
  } else {
    x[[length(x) - n]]
  }
}

help_path <- function(x, package) {

  help <- mapply(locate_help_doc, x, package, SIMPLIFY = FALSE)

  vapply(help,
         function(x) if (length(x) == 0) NA_character_ else as.character(x),
         FUN.VALUE = character(1)
  )
}

locate_help_doc <- function(x, package) {
  help <- if (requireNamespace("pkgload", quietly = TRUE)) {
    shim_help <- get("shim_help", asNamespace("pkgload"))
    function(x, package = NULL) {
      tryCatch(
        expr = shim_help(x, (package)),
        error = function(e) character()
      )
    }
  } else {
    utils::help
  }

  if (is.na(package)) {
    help(x)
  } else {
    help(x, (package))
  }
}

as.character.dev_topic <- function(x, ...) {
  sub("[.]Rd$", "", x$path)
}

lookup_package <- function(generic, class, is_s4) {

  lookup_single_package <- function(generic, class, is_s4) {

    if (is_s4) {

      class <- strsplit(class, ",")[[1]]
      fn <- methods::getMethod(generic, class, optional = TRUE)

    } else {

      fn <- utils::getS3method(generic, class, optional = TRUE)

    }

    # Not found
    if (is.null(fn)) {
      return(NA_character_)
    }

    pkg <- utils::packageName(environment(fn))

    # Function method found, but in a non-package environment
    if (is.null(pkg)) {
      return(NA_character_)
    }

    pkg
  }

  pkgs <- mapply(lookup_single_package, generic, class, is_s4, SIMPLIFY = FALSE)
  as.vector(pkgs, "character")
}

# nocov end
