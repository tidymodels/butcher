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
#' # Load libraries
#' suppressWarnings(suppressMessages(library(parsnip)))
#' suppressWarnings(suppressMessages(library(glmnet)))
#'
#' # Load data
#' set.seed(1234)
#' predictrs <- matrix(rnorm(100*20), ncol = 20)
#' response <- as.factor(sample(1:4, 100, replace = TRUE))
#'
#' # Create model and fi
#' multnet_fit <- multinom_reg() %>%
#'   set_engine("glmnet") %>%
#'   fit_xy(x = predictrs, y = response)
#'
#' out <- butcher(multnet_fit, verbose = TRUE)
#'
#' # Another multnet object
#' fit <- glmnet(predictrs, response, family = "multinomial")
#' out2 <- butcher(fit, verbose = TRUE)
#'
#' # Same predictions
#' original_prediction <- predict(fit, predictrs[c(55, 61, 78), ])
#' butchered_prediction <- predict(out2, predictrs[c(55, 61, 78), ])
#' identical(original_prediction,
#'           butchered_prediction)
#'
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
