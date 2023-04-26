#' Console Messages
#'
#' These console messages are created such that the user is
#' aware of the effects of removing specific components from
#' the model object.
#'
#' @param og Original model object.
#' @param butchered Butchered model object.
#'
#' @keywords internal
#' @name ui

#' @rdname ui
memory_released <- function(og, butchered) {
  old <- lobstr::obj_size(og)
  new <- lobstr::obj_size(butchered)
  rel <- old - new
  if (length(rel) == 1) {
    if (isTRUE(all.equal(old, new))) {
      return(NULL)
    }
    return(rel)
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
    cli::cli_alert_danger("No memory released. Do not butcher.")
  } else {
    abs_mem <- format(abs(mem), big.mark = ",", scientific = FALSE)
    if (mem < 0) {
      cli::cli_alert_danger("The butchered object is {.field {abs_mem}} larger than the original. Do not butcher.")
    } else {
      cli::cli_alert_success("Memory released: {.field {abs_mem}}")
      if (!is.null(disabled)) {
        cli::cli_alert_danger("Disabled: {.code {disabled}}")
      }
      if (length(class_added) == 0) {
        class_name <- "butchered"
        cli::cli_alert_danger("Could not add {.cls {class_name}} class")
      }
    }
  }
}
