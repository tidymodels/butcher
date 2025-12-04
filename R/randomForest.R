#' Axing an randomForest.
#'
#' randomForest objects are created from the \code{randomForest}
#' package, which is used to train random forests based on Breiman's
#' 2001 work. The package supports ensembles of classification and
#' regression trees.
#'
#' @inheritParams butcher
#'
#' @return Axed randomForest object.
#'
#' @examplesIf rlang::is_installed(c("parsnip", "rsample", "rpart", "randomForest"))
#' # Load libraries
#' library(parsnip)
#' library(rsample)
#' library(randomForest)
#' data(kyphosis, package = "rpart")
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, prop = 9/10)
#' spine_train <- training(split)
#'
#' # Create model and fit
#' randomForest_fit <- rand_forest(mode = "classification",
#'                                 mtry = 2,
#'                                 trees = 2,
#'                                 min_n = 3) |>
#'   set_engine("randomForest") |>
#'   fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)
#'
#' out <- butcher(randomForest_fit, verbose = TRUE)
#'
#' # Another randomForest object
#' wrapped_rf <- function() {
#'   some_junk_in_environment <- runif(1e6)
#'   randomForest_fit <- randomForest(mpg ~ ., data = mtcars)
#'   return(randomForest_fit)
#' }
#'
#' # Remove junk
#' cleaned_rf <- axe_env(wrapped_rf(), verbose = TRUE)
#'
#' # Check size
#' lobstr::obj_size(cleaned_rf)
#'
#' @name axe-randomForest
NULL

#' Remove the call.
#'
#' @rdname axe-randomForest
#' @export
axe_call.randomForest <- function(x, verbose = FALSE, ...) {
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
#' @rdname axe-randomForest
#' @export
axe_ctrl.randomForest <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "inbag", matrix(NA))

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove the environment.
#'
#' @rdname axe-randomForest
#' @export
axe_env.randomForest <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}
