test_that("mda + predict() works", {
  skip_on_cran()
  skip_if_not_installed("mda")
  suppressPackageStartupMessages(library(mda))
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

test_that("mda + custom parsnip model + predict() works", {
  skip_on_cran()
  skip_if_not_installed("mda")
  skip_if_not_installed("parsnip")
  suppressPackageStartupMessages(library(mda))
  suppressPackageStartupMessages(library(parsnip))
  # Create a custom parsnip model using mda engine
  set_new_model("mixture_da")
  set_model_mode(model = "mixture_da", mode = "classification")
  set_model_engine(
    "mixture_da",
    mode = "classification",
    eng = "mda"
  )
  set_model_arg(
    model = "mixture_da",
    eng = "mda",
    parsnip = "sub_classes",
    original = "subclasses",
    func = list(pkg = "foo", fun = "bar"),
    has_submodel = FALSE
  )
  mixture_da <- function(mode = "classification",  sub_classes = NULL) {
    if (mode  != "classification") {
      stop("`mode` should be 'classification'", call. = FALSE)
    }
    args <- list(sub_classes = rlang::enquo(sub_classes))
    new_model_spec(
      "mixture_da",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }
  set_fit(
    model = "mixture_da",
    eng = "mda",
    mode = "classification",
    value = list(
      interface = "formula",
      protect = c("formula", "data"),
      func = c(pkg = "mda", fun = "mda"),
      defaults = list()
    )
  )
  set_encoding(
    model = "mixture_da",
    eng = "mda",
    mode = "classification",
    options = list(
      predictor_indicators = "traditional",
      compute_intercept = TRUE,
      remove_intercept = TRUE,
      allow_sparse_x = FALSE
    )
  )
  mda_fit <- mixture_da(sub_classes = 2) %>%
    set_engine("mda") %>%
    fit(Species ~ ., data = iris)
  x <- axe_call(mda_fit)
  expect_equal(x$fit$call, rlang::expr(dummy_call()))
  expect_error(update(x$fit, subclasses = 4))
  expect_equal(attr(x$fit, "butcher_disabled"),
               c("print()", "summary()", "update()"))
  x <- axe_env(mda_fit)
  expect_identical(attr(x$fit$terms, ".Environment"), rlang::base_env())
  x <- axe_fitted(mda_fit)
  expect_equal(x$fit$fit$fitted.values, matrix(NA))
})

test_that("fda + predict() works", {
  skip_on_cran()
  skip_if_not_installed("mda")
  suppressPackageStartupMessages(library(mda))
  mtcars$cyl <- as.factor(mtcars$cyl)
  fit <- fda(cyl ~ ., data = mtcars)
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
  expect_equal(predict(x, mtcars[1:3, ]),
               predict(fit, mtcars[1:3, ]))
})
