test_that("nested_model_fit + axe_() works", {
  skip_if_not_installed("parsnip")
  skip_if_not_installed("nestedmodels")

  model <- nestedmodels::nested(
    parsnip::set_engine(parsnip::linear_reg(), "lm")
  )

  # tidyr is a dependency of nestedmodels
  nested_data <- tidyr::nest(nestedmodels::example_nested_data, data = -id)

  nm_fit <- parsnip::fit(model, z ~ x + y + a + b, nested_data)

  x <- axe_call(nm_fit)

  expect_equal(x$fit$.model_fit[[1]], axe_call(nm_fit$fit$.model_fit[[1]]))

  x <- axe_ctrl(nm_fit)

  expect_equal(x$fit$.model_fit[[1]], axe_ctrl(nm_fit$fit$.model_fit[[1]]))

  x <- axe_data(nm_fit)

  expect_equal(x$fit$.model_fit[[1]], axe_data(nm_fit$fit$.model_fit[[1]]))

  x <- axe_env(nm_fit)

  expect_equal(x$fit$.model_fit[[1]], axe_env(nm_fit$fit$.model_fit[[1]]))

  x <- axe_fitted(nm_fit)

  expect_equal(x$fit$.model_fit[[1]], axe_fitted(nm_fit$fit$.model_fit[[1]]))

  expect_equal(
    attr(x, "butcher_disabled"),
    attr(x$fit$.model_fit[[5]]$fit, "butcher_disabled")
  )

  x <- butcher(nm_fit)

  expect_equal(
    attr(x, "butcher_disabled"),
    attr(x$fit$.model_fit[[1]]$fit, "butcher_disabled")
  )

  expect_equal(x$fit$.model_fit[[1]], butcher(nm_fit$fit$.model_fit[[1]]))

  # Predict
  expect_equal(
    predict(x, nestedmodels::example_nested_data),
    predict(nm_fit, nestedmodels::example_nested_data)
  )
})
