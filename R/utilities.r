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

# Ported and adpated from stats
remove_response <- function(x) {
  a <- attributes(x$terms)
  y <- a$response
  if(!is.null(y) && y) {
    x[[2L]] <- NULL
    a$response <- 0
    a$variables <- a$variables[-(1+y)]
    a$predvars <- a$predvars[-(1+y)]
    if(length(a$factors))
      a$factors <- a$factors[-y, , drop = FALSE]
    if(length(a$offset))
      a$offset <- ifelse(a$offset > y, a$offset-1, a$offset)
    if(length(a$specials))
      for(i in seq_along(a$specials)) {
        b <- a$specials[[i]]
        a$specials[[i]] <- ifelse(b > y, b-1, b)
      }
    attributes(x$terms) <- a
  }
  x
}
