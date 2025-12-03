skip_if_not_installed("xrf")

test_that("xrf + axe_call() works", {
  res <-
    xrf::xrf(
      mpg ~ .,
      mtcars,
      xgb_control = list(nrounds = 2, max_depth = 2),
      family = 'gaussian'
    )
  x <- axe_call(res)

  # due to new xgboost version
  # https://github.com/tidymodels/butcher/issues/294
  if (is.null(x$xgb$call)) {
    expect_equal(attr(x$xgb, "call"), rlang::expr(dummy_call()))
  } else {
    expect_equal(x$xgb$call, rlang::expr(dummy_call()))
  }

  expect_equal(x$glm$model$glmnet.fit$call, rlang::expr(dummy_call()))
  expect_equal(x$glm$model$call, rlang::expr(dummy_call()))
})

test_that("xrf + axe_env() works", {
  res <-
    xrf::xrf(
      mpg ~ .,
      mtcars,
      xgb_control = list(nrounds = 2, max_depth = 2),
      family = 'gaussian'
    )
  x <- axe_env(res)
  expect_equal(attr(x$base_formula, ".Environment"), rlang::base_env())
  expect_equal(
    attr(x$rule_augmented_formula, ".Environment"),
    rlang::base_env()
  )
  expect_equal(attr(x$glm$formula, ".Environment"), rlang::base_env())
  # due to new xgboost version
  # https://github.com/tidymodels/butcher/issues/294
  if (!is.null(x$xgb$callbacks)) {
    expect_equal(environment(x$xgb$callbacks[[1]]), rlang::base_env())
  }
})

test_that("xrf + butcher() works", {
  res <-
    xrf::xrf(
      mpg ~ .,
      mtcars,
      xgb_control = list(nrounds = 2, max_depth = 2),
      family = 'gaussian'
    )
  x <- butcher(res)
  # due to new xgboost version
  # https://github.com/tidymodels/butcher/issues/294
  if (is.null(x$xgb$call)) {
    expect_equal(attr(x$xgb, "call"), rlang::expr(dummy_call()))
  } else {
    expect_equal(x$xgb$call, rlang::expr(dummy_call()))
  }

  expect_equal(x$glm$model$glmnet.fit$call, rlang::expr(dummy_call()))
  expect_equal(x$glm$model$call, rlang::expr(dummy_call()))
  expect_equal(attr(x$base_formula, ".Environment"), rlang::base_env())
  expect_equal(
    attr(x$rule_augmented_formula, ".Environment"),
    rlang::base_env()
  )
  expect_equal(attr(x$glm$formula, ".Environment"), rlang::base_env())
  # due to new xgboost version
  # https://github.com/tidymodels/butcher/issues/294
  if (!is.null(x$xgb$callbacks)) {
    expect_equal(environment(x$xgb$callbacks[[1]]), rlang::base_env())
  }
})

test_that("xrf + predict() works", {
  res <-
    xrf::xrf(
      mpg ~ .,
      mtcars,
      xgb_control = list(nrounds = 2, max_depth = 2),
      family = 'gaussian'
    )
  x <- butcher(res)
  expect_equal(
    predict(x, newdata = head(mtcars))[1],
    predict(res, newdata = head(mtcars))[1]
  )
})
