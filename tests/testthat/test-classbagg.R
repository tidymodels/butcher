context("classbagg")

# Test objects from ipred on the fly instead

# test_that("classbagg + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("classbagg.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("classbagg.rda")))
# })

test_that("classbagg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("ipred")
  skip_if_not_installed("TH.data")
  # Load
  library(ipred)
  library(TH.data)
  # Data
  data("GlaucomaM", package = "TH.data")
  # Fit
  classbagg_fit <- bagging(Class ~ .,
                           data = GlaucomaM,
                           nbagg = 10,
                           coob = TRUE)
  # Butcher
  x_nocall <- axe_call(classbagg_fit)
  expect_equal(x_nocall$call, rlang::expr(dummy_call()))
  expect_equal(x_nocall$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(x_nocall$mtrees[[10]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(predict(x_nocall, newdata = GlaucomaM[c(1, 99), ]),
               structure(2:1, .Label = c("glaucoma", "normal"), class = "factor"))
  x_noenv <- axe_env(classbagg_fit)
  expect_identical(attr(x_noenv$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x_noenv$mtrees[[10]]$btree$terms, ".Environment"), rlang::base_env())
  expect_equal(predict(x_noenv, newdata = GlaucomaM[c(1, 99), ]),
               structure(2:1, .Label = c("glaucoma", "normal"), class = "factor"))
})

