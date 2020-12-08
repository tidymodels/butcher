context("glmnet")

test_that("glmnet + predict() works", {
  skip_on_cran()
  skip_if(do_not_run_glmnet)
  skip_if_not_installed("glmnet")
  library(parsnip)
  model <- logistic_reg(penalty = 10, mixture = 0.1) %>%
    set_engine("glmnet") %>%
    fit(as.factor(vs) ~ ., data = mtcars)
  axed <- axe_call(model)
  expect_equal(axed$fit$call, rlang::expr(dummy_call()))
})
