#' Axing a bart model.
#'
#' @inheritParams butcher
#'
#' @return Axed bart object.
#'
#' @examplesIf rlang::is_installed("dbarts")
#' library(dbarts)
#' x <- dbarts::bart(mtcars[,2:5], mtcars[,1], verbose = FALSE, keeptrees = TRUE)
#' res <- butcher(x, verbose = TRUE)
#'
#' @name axe-bart
NULL

#' @rdname axe-bart
#' @export
axe_call.bart <- function(x, verbose = FALSE, ...) {
  res <- x
  res <- exchange(res, "call", call("dummy_call"))

  add_butcher_attributes(
    res,
    x,
    disabled = c("print()", "summary()"),
    add_class = TRUE,
    verbose = verbose
  )
}

#' @rdname axe-bart
#' @export
axe_fitted.bart <- function(x, verbose = FALSE, ...) {
  res <- x
  res <- exchange(res, "yhat.train", numeric(0))
  res <- exchange(res, "yhat.train.mean", numeric(0))
  if (!is.null(res$yhat.test)) {
    res <- exchange(res, "yhat.test", numeric(0))
    res <- exchange(res, "yhat.test.mean", numeric(0))
  }
  res <- exchange(res, "varcount", numeric(0))

  add_butcher_attributes(
    res,
    x,
    add_class = TRUE,
    verbose = verbose
  )
}
