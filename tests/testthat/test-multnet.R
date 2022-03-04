test_that("multnet + predict() works", {
  skip_on_cran()
  skip_if(do_not_run_glmnet)
  skip_if_not_installed("glmnet")
  suppressPackageStartupMessages(library(parsnip))
  set.seed(1234)
  predictrs <- matrix(rnorm(100*20), ncol = 20)
  colnames(predictrs) <- paste0("a", seq_len(ncol(predictrs)))
  response <- as.factor(sample(1:4, 100, replace = TRUE))
  fit <- multinom_reg(penalty = 1) %>%
    set_engine("glmnet") %>%
    fit_xy(x = predictrs, y = response)
  x <- axe_call(fit)
  expect_equal(x$fit$call, rlang::expr(dummy_call()))
  x <- butcher(fit)
  expect_equal(
    predict(fit, new_data = predictrs[1:3, ], penalty = 1),
    structure(
      list(.pred_class = structure(c(3L, 3L, 3L), .Label = c("1", "2", "3", "4"), class = "factor")), row.names = c(NA, -3L), class = c("tbl_df", "tbl", "data.frame"))
  )
})
