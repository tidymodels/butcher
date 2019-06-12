context("axe_call")

test_that("axe_call() works", {
  # LM
  expect_equal(axe_call(lm_fit)$call, rlang::expr(dummy_call()))
  # GLM
  expect_equal(axe_call(glmnet_fit)$call, rlang::expr(dummy_call()))
  # RPART
  expect_equal(axe_call(treereg_fit)$call, rlang::expr(dummy_call()))
  # Objects without calls: STAN, KERAS

})
