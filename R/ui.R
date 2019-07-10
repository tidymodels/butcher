#' Console Messages
#'
#' These functions leverage the \code{ui.R} as provided in the
#' \pkg{usethis} package. Original reference here:
#' \url{https://github.com/r-lib/usethis/blob/master/R/ui.R}.
#' These console messages are created such that the user is
#' aware of the effects of removing specific components from
#' the modeling object.
#'
#' @param og original model object
#' @param butchered butchered model object
#'
#' @name ui

#' @rdname ui
#' @return pretty version of memory released
memory_released <- function(og, butchered) {
  old <- lobstr::obj_size(og)
  new <- lobstr::obj_size(butchered)
  rel <- old - new
  rel <- format(rel, big.mark = ",", scientific = FALSE)
  if(length(rel) == 1) {
    return(paste(rel, "B"))
  } else {
    return(paste("0", "B"))
  }
}

#' @rdname ui
#' @param working string of tested working functions
#' @param broken string of nonworking functions
#' @param class_added boolean default to true when butcher class appended
#' @return console messages
assess_object <- function(og, butchered,
                          working = NULL,
                          broken = NULL,
                          class_added = TRUE) {
  mem <- memory_released(og, butchered)
  ui_done("Memory released: {ui_value(mem)}")
  if(!is.null(working)) {
    ui_done("Active: {ui_code(working)}")
  }
  if(!is.null(broken)) {
    ui_oops("Inactive: {ui_code(broken)}")
  }
  if(!class_added) {
    class_name <- "butchered"
    ui_oops("Could not append additional {ui_value(class_name)} class")
  }
}

