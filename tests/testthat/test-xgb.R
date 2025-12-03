# TODO: this particular model relies on a setup and teardown infrastructure
# since saving the model object from xgboost in R results in a handle
# (pointer) to an internal xgboost model that is invalid

test_that("xgb.Booster + linear solver + predict() works", {
  skip_on_cran()
  skip_if_not_installed("xgboost")
  suppressPackageStartupMessages(library(xgboost))
  # Load data
  data(agaricus.train)
  data(agaricus.test)
  if (utils::packageVersion("xgboost") > "2.0.0.0") {
    bst <- xgboost(
      x = agaricus.train$data,
      y = agaricus.train$label,
      learning_rate = 1,
      nthread = 2,
      nrounds = 2,
      eval_metric = "logloss",
      objective = "reg:squarederror"
    )
  } else {
    bst <- xgboost(
      data = agaricus.train$data,
      label = agaricus.train$label,
      eta = 1,
      nthread = 2,
      nrounds = 2,
      eval_metric = "logloss",
      objective = "binary:logistic",
      verbose = 0
    )
  }
  x <- axe_call(bst)
  if (utils::packageVersion("xgboost") > "2.0.0.0") {
    extracted_call <- attr(x, "call")
  } else {
    extracted_call <- x$call
  }
  expect_equal(extracted_call, rlang::expr(dummy_call()))
  x <- axe_env(bst)
  expect_lte(lobstr::obj_size(x), lobstr::obj_size(bst))
  expect_lte(lobstr::obj_size(attributes(x)), lobstr::obj_size(attributes(bst)))
  x <- butcher(bst)
  expect_equal(xgb.importance(model = x), xgb.importance(model = bst))
  expect_equal(predict(x, agaricus.test$data), predict(bst, agaricus.test$data))
  expect_equal(xgb.dump(x, with_stats = TRUE), xgb.dump(bst, with_stats = TRUE))
})

test_that("xgb.Booster + tree-learning algo + predict() works", {
  skip_on_cran()
  skip_if_not_installed("xgboost")
  suppressPackageStartupMessages(library(xgboost))
  # Load data
  data(agaricus.train)
  data(agaricus.test)
  dtrain <- xgb.DMatrix(
    data = agaricus.train$data,
    label = agaricus.train$label
  )
  if (utils::packageVersion("xgboost") > "2.0.0.0") {
    bst <- xgb.train(
      params = list(
        booster = "gblinear",
        nthread = 2,
        eval_metric = "logloss",
        objective = "binary:logistic",
        print_every_n = 10000L
      ),
      nrounds = 2,
      data = dtrain
    )
  } else {
    bst <- xgb.train(
      data = dtrain,
      booster = "gblinear",
      nthread = 2,
      nrounds = 2,
      eval_metric = "logloss",
      objective = "binary:logistic",
      print_every_n = 10000L
    )
  }
  x <- axe_call(bst)
  if (utils::packageVersion("xgboost") > "2.0.0.0") {
    extracted_call <- attr(x, "call")
  } else {
    extracted_call <- x$call
  }
  expect_equal(extracted_call, rlang::expr(dummy_call()))
  x <- axe_env(bst)
  expect_lte(lobstr::obj_size(x), lobstr::obj_size(bst))
  expect_lte(lobstr::obj_size(attributes(x)), lobstr::obj_size(attributes(bst)))
  x <- butcher(bst)
  expect_equal(xgb.importance(model = x), xgb.importance(model = bst))
  expect_equal(predict(x, agaricus.test$data), predict(bst, agaricus.test$data))
  expect_equal(xgb.dump(x, with_stats = TRUE), xgb.dump(bst, with_stats = TRUE))
})
