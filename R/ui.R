#' Console Messages
#'
#' These functions leverage the \code{ui.R} as provided in the
#' \pkg{usethis} package. Original reference here:
#' \url{https://github.com/r-lib/usethis/blob/master/R/ui.R}.
#' These console messages are created such that the user is
#' aware of the effects of removing specific components from
#' the model object.
#'
#' @param og Original model object.
#' @param butchered Butchered model object.
#'
#' @name ui

#' @rdname ui
memory_released <- function(og, butchered) {
  old <- lobstr::obj_size(og)
  new <- lobstr::obj_size(butchered)
  rel <- old - new
  rel <- format(rel, big.mark = ",", scientific = FALSE)
  if (length(rel) == 1) {
    if (rel <= 0) {
      return(NULL)
    } else {
      return(paste(rel, "B"))
    }
  } else {
    return(NULL)
  }
}

#' @rdname ui
#' @param disabled String of disabled functions as a result of axing.
#' @param class_added Boolean that defaults to true when butcher class is added.
assess_object <- function(og, butchered,
                          disabled = NULL,
                          class_added = TRUE) {
  mem <- memory_released(og, butchered)
  if (is.null(mem)) {
    ui_oops("No memory released. Do not butcher.")
  } else {
    ui_done("Memory released: {ui_value(mem)}")
    if (!is.null(disabled)) {
      ui_oops("Disabled: {ui_code(disabled)}")
    }
    if (!class_added) {
      class_name <- "butchered"
      ui_oops("Could not add {ui_value(class_name)} class")
    }
  }
}

clean_function_names <- function(output) {
  output <- trimws(output)
  output <- unlist(strsplit(output, ", "))
  gsub("[`!?\\-]", "", output)
}

read_tempfile <- function(filename) {
  temp <- utils::read.delim(filename, header = FALSE, stringsAsFactors = FALSE)
  all_disabled <- c()
  for (i in 1:dim(temp)[1]) {
    output <- unlist(strsplit(temp[i, 1], ":"))
    if (length(grep("Disabled", output[1])) != 0) {
      new <- clean_function_names(output[2])
      all_disabled <- union(all_disabled, new)
    }
  }
  return(all_disabled)
}
