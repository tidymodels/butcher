context("stanreg")

test_that("stanreg + butcher() works", {
  skip_on_cran()
  skip_if_not_installed("rstanarm")
  skip_if_not_installed("parsnip")
  library(parsnip)
  ctrl <- fit_control(verbosity = 0) # Avoid printing output
  stanreg_fit <- linear_reg() %>%
    set_engine("stan") %>%
    fit(mpg ~ ., data = mtcars, control = ctrl)
  x <- axe_call(stanreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(stanreg_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(attributes(x$model)$terms, ".Environment"), rlang::base_env())
  expect_identical(x$stanfit@.MISC, rlang::empty_env())
  expect_identical(x$stanfit@stanmodel@dso@.CXXDSOMISC, rlang::empty_env())
  x <- axe_fitted(stanreg_fit)
  expect_equal(x$fitted.values, numeric(0))
  x <- butcher(stanreg_fit)
  expect_equal(class(x)[1], "butchered_stanreg")
  expected_output <- predict(stanreg_fit$fit)
  expect_equal(predict(x), expected_output)
})
