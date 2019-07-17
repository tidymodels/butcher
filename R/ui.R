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
assess_object <- function(og, butchered) {
  mem <- memory_released(og, butchered)
  disabled <- attr(butchered, "butcher_disabled")
  class_added <- grep("butcher", class(butchered)[1])
  if (is.null(mem)) {
    ui_oops("No memory released. Do not butcher.")
  } else {
    ui_done("Memory released: {ui_value(mem)}")
    if (!is.null(disabled)) {
      ui_oops("Disabled: {ui_code(disabled)}")
    }
    if (length(class_added) == 0) {
      class_name <- "butchered"
      ui_oops("Could not add {ui_value(class_name)} class")
    }
  }
}
