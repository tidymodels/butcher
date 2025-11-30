#' Axing a C5.0.
#'
#' C5.0 objects are created from the \code{C50} package, which provides an
#' interface to the C5.0 classification model. The models that can be
#' generated include basic tree-based models as well as rule-based models.
#'
#' @inheritParams butcher
#'
#' @return Axed C5.0 object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "rsample", "rpart"))
#' # Load libraries
#' library(parsnip)
#' library(rsample)
#' library(rpart)
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, prop = 9/10)
#' spine_train <- training(split)
#'
#' # Create model and fit
#' c5_fit <- decision_tree(mode = "classification") %>%
#'   set_engine("C5.0") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' out <- butcher(c5_fit, verbose = TRUE)
#'
#' # Try another model from parsnip
#' c5_fit2 <- boost_tree(mode = "classification", trees = 100) %>%
#'   set_engine("C5.0") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#' out <- butcher(c5_fit2, verbose = TRUE)
#'
#' # Create model object from original library
#' library(C50)
#' library(modeldata)
#' data(mlc_churn)
#' c5_fit3 <- C5.0(x = mlc_churn[, -20], y = mlc_churn$churn)
#' out <- butcher(c5_fit3, verbose = TRUE)
#'
#' @name axe-C5.0
NULL

#' Remove the call.
#'
#' @rdname axe-C5.0
#' @export
axe_call.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove controls.
#'
#' @rdname axe-C5.0
#' @export
axe_ctrl.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = c("C5.0Control()", "C5imp()"),
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-C5.0
#' @export
axe_fitted.C5.0 <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "output", character(0))

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary()", "C5.0Control()", "C5imp()"),
    verbose = verbose
  )
}
