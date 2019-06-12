context("axe_env")

test_that("axe_env() works", {
  # LM
  expect_null(attr(axe_env(lm_fit)$terms, ".Environment"))
  # GLMNET
  expect_null(attr(axe_env(glmnet_fit)$terms, ".Environment"))
  # STAN
  stan_axed <- axe_env(stan_fit)
  expect_null(attr(stan_axed$terms, ".Environment"))
  expect_null(attr(attributes(stan_axed$model)$terms, ".Environment"))
  expect_true(identical(stan_axed$stanfit@.MISC, rlang::empty_env()))
})


