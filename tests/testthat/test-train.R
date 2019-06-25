context("train")

# Load testing data
test_data <- iris[1:3, 1:4]

test_that("train + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("train.rda" %in% example_files)
  expect_true(file.exists(butcher_example("train.rda")))
})

load(butcher_example("train.rda"))

test_that("train + predict() works", {
  x <- butcher(train_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$control, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_equal(x$pred, list(NULL))
  expect_null(attributes(x$modelInfo$grid))
  expect_equal(predict(x, newdata = test_data),
               structure(c(1L, 1L, 1L), .Label = c("setosa", "versicolor", "virginica"
               ), class = "factor"))

})
