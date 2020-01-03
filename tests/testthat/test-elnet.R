context("elnet")

test_that("elnet + predict() works", {
  skip_on_cran()
  skip_if(do_not_run_glmnet)
  skip_if_not_installed("glmnet")
  library(parsnip)
  elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
    set_engine("glmnet") %>%
    fit_xy(x = mtcars[, 2:11], y = mtcars[, 1, drop = FALSE])
  x <- butcher(elnet_fit)
  new_data <- as.matrix(mtcars[1:3, 2:11])
  expect_equal(
    as.numeric(predict(elnet_fit, new_data)[1,1]),
    22.2011977245072
  )
  x <- axe_call(elnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

