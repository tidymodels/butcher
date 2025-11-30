#' Axing a xgb.Booster.
#'
#' xgb.Booster objects are created from the \pkg{xgboost} package,
#' which provides efficient and scalable implementations of gradient
#' boosted decision trees. Given the reliance of post processing
#' functions on the model object, like \code{xgb.Booster.complete},
#' on the first class listed, the \code{butcher_xgb.Booster} class is
#' not appended.
#'
#' @inheritParams butcher
#'
#' @return Axed xgb.Booster object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "xgboost"))
#' library(xgboost)
#' library(parsnip)
#'
#' data(agaricus.train)
#' bst <- xgboost(data = agaricus.train$data,
#'                label = agaricus.train$label,
#'                eta = 1,
#'                nthread = 2,
#'                nrounds = 2,
#'                eval_metric = "logloss",
#'                objective = "binary:logistic",
#'                verbose = 0)
#'
#' out <- butcher(bst, verbose = TRUE)
#'
#' # Another xgboost model
#' fit <- boost_tree(mode = "classification", trees = 20) %>%
#'   set_engine("xgboost", eval_metric = "mlogloss") %>%
#'   fit(Species ~ ., data = iris)
#'
#' out <- butcher(fit, verbose = TRUE)
#'
#' @name axe-xgb.Booster
NULL

#' Remove the call.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_call.xgb.Booster <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c(
      "print()",
      "summary()",
      "xgb.Booster.complete()"
    ),
    add_class = FALSE,
    verbose = verbose
  )
}

#' Remove environments.
#'
#' @rdname axe-xgb.Booster
#' @export
axe_env.xgb.Booster <- function(x, verbose = FALSE, ...) {
  old <- x
  x$callbacks <- purrr::map(x$callbacks,
    function(x)
      as.function(c(formals(x), body(x)), env = rlang::base_env())
    )

  add_butcher_attributes(
    x,
    old,
    add_class = FALSE,
    verbose = verbose
  )
}
