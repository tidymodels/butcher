context("randomForest")

test_that("randomForest + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("randomForest.rda" %in% example_files)
  expect_true(file.exists(butcher_example("randomForest.rda")))
})


test_that("randomForest + predict() works", {
  skip_on_cran()
  skip_if_not_installed("randomForest")
  load(butcher_example("randomForest.rda"))
  x <- butcher(randomForest_fit)
  expect_equal(x$call, call("dummy_call"))
  expect_equal(predict(x)[1:6], structure(c(`2` = 2L, `3` = 1L, `4` = 2L, `5` = 1L, `6` = NA, `7` = NA), .Label = c("absent", "present"), class = "factor"))
})
