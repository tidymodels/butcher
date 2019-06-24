context("sclass")

test_that("sclass + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("classbagg.rda" %in% example_files)
  expect_true(file.exists(butcher_example("classbagg.rda")))
})

load(butcher_example("classbagg.rda"))
x <- classbagg_fit$mtrees[[1]]

test_that("sclass + axe_() works", {
  x_nocall <- axe_call(x)
  expect_equal(x_nocall$btree$call, rlang::expr(dummy_call()))
  x_noenv <- axe_env(x)
  expect_identical(attr(x_noenv$btree$terms, ".Environment"), rlang::base_env())
})
