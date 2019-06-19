context("randomForest")

# library(rpart)
library(randomForest)

test_that("randomForest + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("randomForest.rda" %in% example_files)
  expect_true(file.exists(butcher_example("randomForest.rda")))
})

load(butcher_example("randomForest.rda"))

test_that("randomForest + predict() works", {
  x <- axe(randomForest_fit)
  expect_equal(predict(x)[1:6], structure(c(`2` = 2L, `3` = 1L, `4` = 2L, `5` = 1L, `6` = NA, `7` = NA), .Label = c("absent", "present"), class = "factor"))
  # new_data <- kyphosis[1:3, ] // TODO: what is string mismatch here?
  # expected_output <- predict(randomForest_fit$fit, newdata = new_data)
  # expect_equal(predict(x, newdata = new_data)[1], structure(c(`1` = 1L), .Label = c("absent", "present"), class = "factor"))
})
