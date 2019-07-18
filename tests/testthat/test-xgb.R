context("xgb.Booster")

# TODO: this particular model relies on a setup and teardown infrastructure
# since saving the model object from xgboost in R results in a handle
# (pointer) to an internal xgboost model that is invalid

test_that("xgb.Booster + linear solver + predict() works", {
  skip_on_cran()
  skip_if_not_installed("xgboost")
  library(xgboost)
  # Load data
  data(agaricus.train)
  data(agaricus.test)
  bst <- xgboost(data = agaricus.train$data,
                 label = agaricus.train$label,
                 max.depth = 2,
                 eta = 1,
                 nthread = 2,
                 nrounds = 2,
                 objective = "binary:logistic")
  x <- axe_call(bst)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(bst)
  expect_lt(lobstr::obj_size(x), lobstr::obj_size(bst))
  x <- axe_ctrl(bst)
  expect_equal(x$params, list(NULL))
  x <- axe_fitted(bst)
  expect_equal(x$raw, raw())
  x <- butcher(bst)
  expect_equal(xgb.importance(model = x),
               xgb.importance(model = bst))
  expect_equal(predict(x, agaricus.test$data),
               predict(bst, agaricus.test$data))
  expect_equal(xgb.dump(x, with_stats = TRUE),
               xgb.dump(bst, with_stats = TRUE))
})

test_that("xgb.Booster + tree-learning algo + predict() works", {
  skip_on_cran()
  skip_if_not_installed("xgboost")
  library(xgboost)
  # Load data
  data(agaricus.train)
  data(agaricus.test)
  dtrain <- xgb.DMatrix(data = agaricus.train$data,
                        label = agaricus.train$label)
  bst <- xgb.train(data = dtrain,
                   booster = "gblinear",
                   max.depth = 2,
                   nthread = 2,
                   nrounds = 2,
                   eval.metric = "error",
                   eval.metric = "logloss",
                   objective = "binary:logistic")
  x <- axe_call(bst)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_env(bst)
  expect_lt(lobstr::obj_size(x), lobstr::obj_size(bst))
  x <- axe_ctrl(bst)
  expect_equal(x$params, list(NULL))
  x <- axe_fitted(bst)
  expect_equal(x$raw, raw())
  x <- butcher(bst)
  expect_equal(xgb.importance(model = x),
               xgb.importance(model = bst))
  expect_equal(predict(x, agaricus.test$data),
               predict(bst, agaricus.test$data))
  expect_equal(xgb.dump(x, with_stats = TRUE),
               xgb.dump(bst, with_stats = TRUE))
})
