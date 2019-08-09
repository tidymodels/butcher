#' Axing an kknn.
#'
#' kknn objects are created from the \pkg{kknn} package, which is
#' utilized to do weighted k-Nearest Neighbors for classification,
#' regression and clustering.
#'
#' @inheritParams butcher
#'
#' @return Axed kknn object.
#'
#' @examples
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(rsample)))
#' suppressWarnings(suppressMessages(library(rpart)))
#' suppressWarnings(suppressMessages(library(kknn)))
#'
#' # Load data
#' set.seed(1234)
#' split <- initial_split(kyphosis, props = 9/10)
#' spine_train <- training(split)
#'
#' # Create model and fit
#' kknn_fit <- nearest_neighbor(mode = "classification",
#'                              neighbors = 3,
#'                              weight_func = "gaussian",
#'                              dist_power = 2) %>%
#'   set_engine("kknn") %>%
#'   fit(Kyphosis ~ ., data = spine_train)
#'
#' out <- butcher(kknn_fit, verbose = TRUE)
#'
#' \donttest{
#' # Another kknn model object
#' m <- dim(iris)[1]
#' val <- sample(1:m,
#'               size = round(m/3),
#'               replace = FALSE,
#'               prob = rep(1/m, m))
#' iris.learn <- iris[-val,]
#' iris.valid <- iris[val,]
#' kknn_fit <- kknn(Species ~ .,
#'                  iris.learn,
#'                  iris.valid,
#'                  distance = 1,
#'                  kernel = "triangular")
#' out <- butcher(kknn_fit, verbose = TRUE)
#' }
#' @name axe-kknn
NULL

#' Remove the call.
#'
#' @rdname axe-kknn
#' @export
axe_call.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}

#' Remove the environment.
#'
#' @rdname axe-kknn
#' @export
axe_env.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x$terms <- axe_env(x$terms, ...)

  add_butcher_attributes(
    x,
    old,
    verbose = verbose
  )
}

#' Remove fitted values.
#'
#' @rdname axe-kknn
#' @export
axe_fitted.kknn <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "fitted.values", list(NULL))

  add_butcher_attributes(
    x,
    old,
    disabled = c("fitted()"),
    verbose = verbose
  )
}
