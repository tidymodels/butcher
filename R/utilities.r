remove_env <- function(x, list_attributes) {
  locate_env <- purrr::map_lgl(list_attributes, is.environment)
  locate_env <- names(list_attributes[locate_env])
  indexes <- rlang::syms(unlist(strsplit(locate_env, "..Environment")))
  parsed_indexes <- lapply(indexes, function(z) rlang::expr(attr(`$`(x, !!z), ".Environment") <- NULL))
  for(i in 1:length(parsed_indexes)) {
    eval(parsed_indexes[[i]])
  }
  return(x)
}
