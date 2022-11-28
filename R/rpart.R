#' Axing a rpart.
#'
#' rpart objects are created from the \pkg{rpart} package, which
#' is used for recursive partitioning for classification, regression and
#' survival trees.
#'
#' @inheritParams butcher
#'
#' @return Axed rpart object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "rsample", "rpart"))
#' # Load libraries
#' library(parsnip)
#' library(rsample)
#' library(rpart)
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(mtcars, props = 9/10)
#' car_train <- training(split)
#'
#' # Create model and fit
#' rpart_fit <- decision_tree(mode = "regression") %>%
#'   set_engine("rpart") %>%
#'   fit(mpg ~ ., data = car_train, minsplit = 5, cp = 0.1)
#'
#' out <- butcher(rpart_fit, verbose = TRUE)
#'
#' # Another rpart object
#' wrapped_rpart <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   fit <- rpart(Kyphosis ~ Age + Number + Start,
#'                data = kyphosis,
#'                x = TRUE, y = TRUE)
#'   return(fit)
#' }
#'
#' # Remove junk
#' cleaned_rpart <- axe_env(wrapped_rpart(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_rpart)
#'
#' @name axe-rpart
NULL

#' Remove calls.
#'
#' @rdname axe-rpart
#' @export
axe_call.rpart <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))
  x <- exchange(x, "functions", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("summary()", "printcp()"),
    verbose = verbose
  )
}

#' Remove controls.
#'
#' @rdname axe-rpart
#' @export
axe_ctrl.rpart <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "control", list(NULL), "usesurrogate", old)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove data.
#'
#' @rdname axe-rpart
#' @export
axe_data.rpart <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "y", numeric(0))
  x <- exchange(x, "x", matrix(NA))

  add_butcher_attributes(
    x,
    old,
    disabled = c("xpred.rpart()"),
    verbose = verbose
  )
}

#' Remove the environment.
#'
#' @rdname axe-rpart
#' @export
axe_env.rpart <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
