remove_env <- function(x, list_attributes) {
  locate_env <- purrr::map_lgl(list_attributes, is.environment)
  locate_env <- names(list_attributes[locate_env])
  indexes <- syms(unlist(strsplit(locate_env, "..Environment")))
  parsed_indexes <- lapply(indexes, function(z) expr(`$`(x, !!z)))
  for(i in 1:length(parsed_indexes)) {
    # attr(parsed_indexes[[i]], ".Environment") <- NULL FIX THIS
    attr(eval(parsed_indexes[[i]]), ".Environment") <- NULL
  }
  return(x)
}
