context("elnet")

test_that("elnet + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("elnet.rda" %in% example_files)
  expect_true(file.exists(butcher_example("elnet.rda")))
})

test_that("elnet + predict() works", {
  skip_on_cran()
  skip_if_not_installed("glmnet")
  load(butcher_example("elnet.rda"))
  x <- butcher(elnet_fit)
  new_data <- as.matrix(mtcars[1:3, 2:11])
  expect_equal(predict(x, new_data)[1], 22.5177880899825)
  x <- axe_call(elnet_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_call(elnet_fit$fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

