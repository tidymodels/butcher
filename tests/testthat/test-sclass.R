test_that("sclass + axe_() works", {
  skip_on_cran()
  skip_if_not_installed("ipred")
  skip_if_not_installed("TH.data")
  # Load
  suppressPackageStartupMessages(library(ipred))
  suppressPackageStartupMessages(library(TH.data))
  # Data
  data("GlaucomaM", package = "TH.data")
  # Fit
  classbagg_fit <- bagging(Class ~ .,
                           data = GlaucomaM,
                           nbagg = 10,
                           coob = TRUE)
  # Parse out sclass object
  x <- classbagg_fit$mtrees[[1]]
  x_nocall <- axe_call(x)
  expect_equal(x_nocall$btree$call, rlang::expr(dummy_call()))
  x_noenv <- axe_env(x)
  expect_identical(attr(x_noenv$btree$terms, ".Environment"), rlang::base_env())
})
