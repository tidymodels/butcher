#' Axing a xgb.Booster.
#'
#' xgb.Booster objects are created from the \pkg{xgboost} package,
#' which provides efficient and scalable implementations of gradient
#' boosted decision trees. Given the reliance of post processing
#' functions on the model object, like \code{xgb.Booster.complete},
#' on the first class listed, the \code{butcher_xgb.Booster} class is
#' not appended. This is where all the xgb.Booster specific documentation
#' lies.
#'
#' @param x Model object.
#' @param verbose Print information each time an axe method is executed
#'  that notes how much memory is released and what functions are
#'  disabled. Default is \code{TRUE}.
#' @param ... Any additional arguments related to axing.
#'
#' @return Axed model object.
#' @examples
#' library(xgboost)
#' data(agaricus.train)
#' data(agaricus.test)
#' bst <- xgboost(data = agaricus.train$data,
#'                label = agaricus.train$label,
#'                max.depth = 2,
#'                eta = 1,
#'                nthread = 2,
#'                nrounds = 2,
#'                objective = "binary:logistic")
#'
#' butcher(bst)
#' @name axe-xgb.Booster
NULL

#' Remove the call.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_call.xgb.Booster <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "print",
      "summary",
      "xgb.Booster.complete"
    ),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove controls used for training.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_ctrl.xgb.Booster <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "params", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print"),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_env.xgb.Booster <- function(x, verbose = TRUE, ...) {
  old <- x
  x$callbacks <- purrr::map(x$callbacks,
    function(x)
      as.function(c(formals(x), body(x)), env = rlang::empty_env())
    )

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove cached memory dump of xgboost model that was saved as a raw
#' data type.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_fitted.xgb.Booster <- function(x, verbose = TRUE, ...) {
  old <- x
  x <- exchange(x, "raw", raw())

  add_butcher_attributes(
    x,
    old,
    disabled = c("xgb.Booster.complete"),
    add_class = FALSE,
    verbose = verbose
  )
}
