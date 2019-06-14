context("axe_env")

test_en <- rlang::empty_env()

test_that("axe_env() works", {
  # LM
  expect_identical(attr(axe_env(lm_fit)$terms, ".Environment"), test_en)
  # STAN
  stan_axed <- axe_env(stan_fit)
  expect_identical(attr(stan_axed$terms, ".Environment"), test_en)
  expect_identical(attr(attributes(stan_axed$model)$terms, ".Environment"), test_en)
  expect_identical(stan_axed$stanfit@.MISC, test_en)
  # RPART
  treereg_axed <- axe_env(treereg_fit)
  expect_identical(attr(treereg_axed$terms, ".Environment"), test_en)
  # FLEXSURVREG
  flex_axed <- axe_env(flex_fit)
  expect_identical(attr(attributes(flex_axed$data$m)$terms, ".Environment"), test_en)
  # Objects without env: KERAS
})


