context("mda")

test_that("mda + predict() works", {
  skip_on_cran()
  skip_if_not_installed("mda")
  library(mda)
  fit <- mda(Species ~ ., data = iris)
  x <- axe_call(fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_error(update(x, subclasses = 4))
  expect_equal(attr(x, "butcher_disabled"),
               c("print()", "summary()", "update()"))
  x <- axe_data(fit)
  expect_identical(x, fit)
  x <- axe_env(fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  x <- axe_fitted(fit)
  expect_equal(x$fit$fitted.values, matrix(NA))
  x <- butcher(fit)
  expect_equal(predict(x, iris[1:3, ]),
               predict(fit, iris[1:3, ]))
})

# test_that("custom parsnip model + mda + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("mda")
#   skip_if_not_installed("parsnip")
#   library(mda)
#   library(parsnip)
#   # Define the model mode
#   mixture_modes <- c("classification", "unknown")
#   # Define engines
#   mixture_engines <- data.frame(
#     mda = c(TRUE),
#     mixture_engines = c(TRUE),
#     row.names = c("classification")
#   )
#   # Define arguments for each engine
#   mixture_arg_key <- data.frame(
#     mda = "subclasses",
#     row.names = "subclasses",
#     stringsAsFactors = FALSE
#   )
#   # Model function
#   mixture <- function(mode = "classification", subclasses = NULL) {
#     # Check correct mode
#     if(!(mode %in% mixture_modes))
#       stop("`mode` is not available!")
#     # Capture args in quosures
#     args <- list(subclasses = rlang::enquo(subclasses))
#     # Save empty slots for future parts of specification
#     out <- list(args = args,
#                 eng_args = NULL,
#                 mode = mode,
#                 method = NULL,
#                 engine = mixture_engines)
#     # Set classes
#     class(out) <- make_classes("mixture")
#     out
#   }
#   # Make model object
#   mixture_data <- list(libs = "mda")
#   mixture_data$fit <- list(
#     interface = "formula",
#     protect = c("formula", "data"),
#     func = c(pkg = "mda", fun = "mda"),
#     defaults = list()
#   )
#   mixture_data$class <- list(
#     pre = NULL,
#     post = NULL,
#     func = c(fun = "predict"),
#     args = list(
#       object = quote(object$fit),
#       newdata = quote(new_data),
#       type = "class"
#     )
#   )
#   mixture_data$classprob <- list(
#     pre = NULL,
#     post = function(x, object) {
#       tibble::as_tibble(x)
#     },
#     func = c(fun = "predict"),
#     args = list(
#       object = quote(object$fit),
#       newdata = quote(new_data),
#       type = "posterior"
#     )
#   )
#   out <- mixture(mode = "classification", subclasses = 2) %>%
#     set_engine("mda")
#     # translate()
#   # Execute on iris
#   # mda_fit <- mixture_da() %>%
#   #   set_engine("mda") %>%
#   #   fit(Species ~ ., data = iris)
#   # Butcher
#   # x <- axe_call(mda_fit)
#   # expect_equal(x$call, rlang::expr(dummy_call()))
#   # expect_error(update(x, subclasses = 4))
#   # expect_equal(attr(x, "butcher_disabled"),
#   #              c("print()", "summary()", "update()"))
#   # x <- axe_data(mda_fit)
#   # expect_identical(x, mda_fit$fit)
#   # x <- axe_env(mda_fit)
#   # expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
#   # x <- axe_fitted(fit)
#   # expect_equal(x$fit$fitted.values, matrix(NA))
#   # x <- butcher(fit)
#   # expect_equal(predict(x, iris[1:3, ]),
#   #              predict(fit, iris[1:3, ]))
# })
