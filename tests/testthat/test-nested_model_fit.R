test_that("nested_model_fit + axe_() works", {
  skip_if_not_installed("parsnip")
  skip_if_not_installed("nestedmodels")

  model <- nestedmodels::nested(
    parsnip::set_engine(parsnip::linear_reg(), "lm")
  )

  # tidyr is a dependency of nestedmodels
  nested_data <- tidyr::nest(nestedmodels::example_nested_data, data = -id)

  fit <- parsnip::fit(model, z ~ x + y + a + b, nested_data)

  x <- axe_call(fit)

  expect_equal(x$.model_fit[[1]], axe_call(fit$.model_fit[[1]]))

  x <- axe_ctrl(fit)

  expect_equal(x$.model_fit[[1]], axe_ctrl(fit$.model_fit[[1]]))

  x <- axe_data(fit)

  expect_equal(x$.model_fit[[1]], axe_data(fit$.model_fit[[1]]))

  x <- axe_env(fit)

  expect_equal(x$.model_fit[[1]], axe_env(fit$.model_fit[[1]]))

  x <- axe_fitted(fit)

  expect_equal(x$.model_fit[[1]], axe_fitted(fit$.model_fit[[1]]))

  x <- butcher(fit)

  expect_equal(x$.model_fit[[1]], butcher(fit$.model_fit[[1]]))

  # Predict
  expect_equal(
    predict(x, nestedmodels::example_nested_data),
    predict(fit, nestedmodels::example_nested_data)
  )
})
