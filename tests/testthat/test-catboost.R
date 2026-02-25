test_that("catboost.Model + axe_call() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- axe_call(model)
  # catboost.Model doesn't store a call, so object should be unchanged
  expect_identical(x, model)
})

test_that("catboost.Model + axe_ctrl() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- axe_ctrl(model)
  # catboost.Model doesn't store controls, so object should be unchanged
  expect_identical(x, model)
})

test_that("catboost.Model + axe_data() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- axe_data(model)
  # catboost.Model doesn't store training data, so object should be unchanged
  expect_identical(x, model)
})

test_that("catboost.Model + axe_env() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- axe_env(model)
  # cpp_obj environment is required, so object should be unchanged
  expect_identical(x, model)
})

test_that("catboost.Model + axe_fitted() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- axe_fitted(model)
  # feature_importances should be removed
  expect_null(x$feature_importances)
  expect_lte(lobstr::obj_size(x), lobstr::obj_size(model))
})

test_that("catboost.Model + butcher() works", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  x <- butcher(model)
  expect_null(x$feature_importances)
  expect_lte(lobstr::obj_size(x), lobstr::obj_size(model))
})

test_that("catboost.Model + predict() works after butcher", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  butchered_mod <- mod
  butchered_mod$fit <- butcher(mod$fit)

  original_pred <- predict(mod, iris)
  butchered_pred <- predict(butchered_mod, iris)

  expect_identical(original_pred, butchered_pred)
})

test_that("weigh() works on catboost.Model", {
  skip_on_cran()
  skip_if_not_installed("catboost")
  skip_if_not_installed("bonsai")
  skip_if_not_installed("parsnip")

  suppressPackageStartupMessages(library(parsnip))
  suppressPackageStartupMessages(library(bonsai))

  mod <- boost_tree(trees = 10) %>%
    set_engine("catboost", verbose = 0) %>%
    set_mode("classification") %>%
    fit(Species ~ ., data = iris)

  model <- mod$fit

  weights <- weigh(model)
  expect_s3_class(weights, "tbl_df")
})
