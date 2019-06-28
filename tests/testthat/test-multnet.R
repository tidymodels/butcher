context("multnet")

test_that("multnet + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("multnet.rda" %in% example_files)
  expect_true(file.exists(butcher_example("multnet.rda")))
})

test_that("multnet + predict() works", {
  skip_on_cran()
  skip_if_not_installed("glmnet")
  load(butcher_example("multnet.rda"))
  x <- butcher(multnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  # Note multnet is very different so it has its own predict function in
  # the glmnet package.
  expect_equal(predict(x, newx = matrix(1, ncol = 20), s= 1)[1,1,1], 0.0881926426624652)
})
