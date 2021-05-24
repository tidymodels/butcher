#' Axing an multnet.
#'
#' multnet objects are created from carrying out multinomial regression
#' in the \pkg{glmnet} package.
#'
#' @inheritParams butcher
#'
#' @return Axed multnet object.
#'
#' @examples
#' \donttest{
#' if (rlang::is_installed("glmnet")) {
#'
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#'
#' # Load data
#' set.seed(1234)
#' predictrs <- matrix(rnorm(100*20), ncol = 20)
#' colnames(predictrs) <- paste0("a", seq_len(ncol(predictrs)))
#' response <- as.factor(sample(1:4, 100, replace = TRUE))
#'
#' # Create model and fit
#' multnet_fit <- multinom_reg(penalty = 0.1) %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = predictrs, y = response)
#'
#' out <- butcher(multnet_fit, verbose = TRUE)
#'
#' }
#' }
#' @name axe-multnet
NULL

#' Remove call.
#'
#' @rdname axe-multnet
#' @export
axe_call.multnet <- function(x, verbose = FALSE, ...) {
  old <- x
  x <- exchange(x, "call", call("dummy_call"))

  add_butcher_attributes(
    x,
    old,
    disabled = c("print()", "summary()"),
    verbose = verbose
  )
}
