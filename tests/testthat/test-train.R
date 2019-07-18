context("train")

test_that("train + knn + predict() works", {
  skip_on_cran()
  skip_if_not_installed("caret")
  library(caret)
  # Model
  train_data <- iris[, 1:4]
  train_classes <- iris[, 5]
  train_fit <- caret::train(train_data,
                            train_classes,
                            method = "knn",
                            preProcess = c("center", "scale"),
                            tuneLength = 10,
                            trControl = caret::trainControl(method = "cv"))
  x <- axe_call(train_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, train_fit$dots)
  x <- axe_ctrl(train_fit)
  expect_equal(x$control$method, train_fit$control$method)
  x <- axe_data(train_fit)
  expect_equal(x$trainingData, data.frame(NA))
  x <- axe_fitted(train_fit)
  expect_equal(x$pred, train_fit$pred)
  expect_equal(x, train_fit)
  x <- axe_env(train_fit)
  expect_null(attr(x$modelInfo$prob, "srcref"))
  expect_null(attr(x$modelInfo$sort, "srcref"))
  x <- butcher(train_fit)
  expect_equal(attr(x, "butcher_disabled"),
               c("summary", "update"))
  # Testing data
  test_data <- iris[1:3, 1:4]
  expect_equal(predict(x, newdata = test_data),
               structure(
                 c(1L, 1L, 1L),
                 .Label = c("setosa",
                            "versicolor",
                            "virginica"),
                 class = "factor"))
})

test_that("train + rda + predict() works", {
  skip_on_cran()
  skip_if_not_installed("caret")
  library(caret)
  # Model
  set.seed(123)
  dat <- twoClassSim(500, intercept = -10)
  train_fit <- train(Class ~ .,
                     data = dat,
                     method = "rda",
                     tuneLength = 4,
                     trControl = trainControl(method = "cv"))
  x <- axe_call(train_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$dots, train_fit$dots)
  x <- axe_ctrl(train_fit)
  expect_equal(x$control$method, train_fit$control$method)
  x <- axe_data(train_fit)
  expect_equal(x$trainingData, data.frame(NA))
  x <- axe_fitted(train_fit)
  expect_equal(x$pred, train_fit$pred)
  expect_equal(x, train_fit)
  x <- axe_env(train_fit)
  expect_null(attr(x$modelInfo$prob, "srcref"))
  expect_null(attr(x$modelInfo$sort, "srcref"))
  x <- butcher(train_fit)
  expect_equal(attr(x, "butcher_disabled"),
               c("summary", "update"))
  expect_equal(predict(x, dat[1:3, ]),
               predict(train_fit, dat[1:3, ]))
})
