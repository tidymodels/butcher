context("train")

# Train objects are large so create on the fly
# test_that("train + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("train.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("train.rda")))
# })

test_that("train + predict() works", {
  skip_on_cran()
  skip_if_not_installed("caret")
  # Model
  train_data <- iris[, 1:4]
  train_classes <- iris[, 5]
  train_fit <- caret::train(train_data, train_classes,
                     method = "knn",
                     preProcess = c("center", "scale"),
                     tuneLength = 10,
                     trControl = caret::trainControl(method = "cv"))
  # Butcher
  x <- butcher(train_fit)
  # Load testing data
  test_data <- iris[1:3, 1:4]
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, list(NULL))
  expect_equal(x$trainingData, data.frame(NA))
  expect_equal(x$pred, list(NULL))
  expect_null(attr(x$modelInfo$prob, "srcref"))
  expect_equal(predict(x, newdata = test_data),
               structure(c(1L, 1L, 1L), .Label = c("setosa", "versicolor", "virginica"
               ), class = "factor"))
})
