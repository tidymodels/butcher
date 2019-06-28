context("classbagg")


test_that("classbagg + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("classbagg.rda" %in% example_files)
  expect_true(file.exists(butcher_example("classbagg.rda")))
})

test_that("classbagg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("ipred")
  skip_if_not_installed("TH.data")
  load(butcher_example("classbagg.rda"))
  data("GlaucomaM", package = "TH.data")
  x <- classbagg_fit
  x_nocall <- axe_call(x)
  expect_equal(x_nocall$call, rlang::expr(dummy_call()))
  expect_equal(x_nocall$mtrees[[1]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(x_nocall$mtrees[[10]]$btree$call, rlang::expr(dummy_call()))
  expect_equal(predict(x_nocall, newdata = GlaucomaM[c(1, 99), ]),
               structure(2:1, .Label = c("glaucoma", "normal"), class = "factor"))
  x_noenv <- axe_env(x)
  expect_identical(attr(x_noenv$mtrees[[1]]$btree$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x_noenv$mtrees[[10]]$btree$terms, ".Environment"), rlang::base_env())
  expect_equal(predict(x_noenv, newdata = GlaucomaM[c(1, 99), ]),
               structure(2:1, .Label = c("glaucoma", "normal"), class = "factor"))
})

