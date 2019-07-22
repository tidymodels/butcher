context("spark")

source("utils.R")

test_that("spark ml_model + tbl_spark input + predict() works", {
  skip_on_cran()
  skip_on_os(c("windows", "solaris"))
  skip_if_not_installed("sparklyr")
  skip_if_not_installed("dplyr")
  # Load
  library(sparklyr)
  library(dplyr)
  # Create connection
  sc <- testthat_spark_connection()
  # Data
  iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
    sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
  train <- iris_tbls$train
  validation <- iris_tbls$validation
  # Model
  spark_fit <- ml_logistic_regression(train, Species ~ .)
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
  # Test sub axe functions
  x <- axe_call(spark_fit)
  expect_equal(x$formula, "")
  x <- axe_ctrl(spark_fit)
  expect_equal(x$label_col, "")
  expect_equal(x$features_col, "")
  expect_equal(x$feature_names, "")
  expect_equal(x$response, "")
  expect_equal(x$index_labels, "")
  x <- axe_data(spark_fit)
  expect_equal(x$dataset, NULL)
  expect_equal(spark_fit$dataset, train)
  x <- axe_fitted(spark_fit)
  expect_equal(x$coefficients, matrix(NA))
  expect_null(x$model)
  expect_null(x$summary)
  # Butcher
  x <- butcher(spark_fit)
  version <- x %>%
    spark_jobj() %>%
    spark_connection() %>%
    spark_version()
  expect_false(version < "2.0.0")
  output <- ml_predict(x$pipeline_model, validation) %>%
    select(predicted_label) %>%
    collect()
  expect_gt(lobstr::obj_size(spark_fit), lobstr::obj_size(x))
  expect_equal(output, expected_output)
  expect_equal(expected_output$predicted_label[1], "setosa")
  expect_null(ml_stages(x))
  # Now test on temp object
  path <- tempfile()
  ml_save(x, path, overwrite = TRUE)
  x_loaded <- ml_load(sc, path)
  path <- tempfile()
  ml_save(spark_fit, path, overwrite = TRUE)
  spark_fit_loaded <- ml_load(sc, path)
  expected_output <- spark_fit_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  new_output <- x_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  expect_equal(new_output, expected_output)
  expect_equal(x_loaded$uid, spark_fit_loaded$uid)
  # Test sub axe functions
  axed_loaded <- axe_call(spark_fit_loaded)
  expect_null(axed_loaded$formula)
  axed_loaded <- axe_ctrl(spark_fit_loaded)
  expect_null(axed_loaded$label_col)
  expect_null(axed_loaded$features_col)
  expect_null(axed_loaded$response)
  expect_null(axed_loaded$index_labels)
  axed_loaded <- axe_data(spark_fit_loaded)
  expect_null(axed_loaded$dataset)
  axed_loaded <- axe_fitted(spark_fit_loaded)
  expect_null(axed_loaded$coefficients)
  # Butcher
  axed_loaded <- butcher(spark_fit_loaded)
  expect_equal(axed_loaded, spark_fit_loaded)
})

test_that("spark decision_tree + predict() works", {
  skip_on_cran()
  skip_if_not_installed("sparklyr")
  skip_if_not_installed("dplyr")
  # Load
  library(sparklyr)
  library(dplyr)
  # Create connection
  sc <- testthat_spark_connection()
  # Data
  iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
    sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
  train <- iris_tbls$train
  validation <- iris_tbls$validation
  spark_fit <- ml_decision_tree_classifier(train, Species ~ .)
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
  # Butcher
  x <- butcher(spark_fit)
  expect_gt(lobstr::obj_size(spark_fit), lobstr::obj_size(x))
  output <- ml_predict(x$pipeline_model, validation) %>%
    select(predicted_label) %>%
    collect()
  expect_equal(output, expected_output)
})

test_that("spark boost_tree + predict() works", {
  skip_on_cran()
  skip_if_not_installed("sparklyr")
  skip_if_not_installed("dplyr")
  # Load
  library(sparklyr)
  library(dplyr)
  # Create connection
  sc <- testthat_spark_connection()
  # Binary classification data
  iris_bin <- iris[iris$Species != "setosa", ]
  iris_bin$Species <- factor(iris_bin$Species)
  iris_bin_tbls <- sdf_copy_to(sc, iris_bin, overwrite = TRUE) %>%
    sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
  train <- iris_bin_tbls$train
  validation <- iris_bin_tbls$validation
  # Model
  spark_fit <- ml_gradient_boosted_trees(train, Species ~ .)
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
  x <- butcher(spark_fit)
  expect_gt(lobstr::obj_size(spark_fit), lobstr::obj_size(x))
  output <- ml_predict(x$pipeline_model, validation) %>%
    select(predicted_label) %>%
    collect()
  expect_equal(output, expected_output)
  # Save and load
  path <- tempfile()
  ml_save(x, path, overwrite = TRUE)
  x_loaded <- ml_load(sc, path)
  path <- tempfile()
  ml_save(spark_fit, path, overwrite = TRUE)
  spark_fit_loaded <- ml_load(sc, path)
  expected_output <- spark_fit_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  new_output <- x_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  expect_equal(new_output, expected_output)
  expect_equal(x_loaded$uid, spark_fit_loaded$uid)
  # Test sub axe functions
  axed_loaded <- axe_call(spark_fit_loaded)
  expect_null(axed_loaded$formula)
  axed_loaded <- axe_ctrl(spark_fit_loaded)
  expect_null(axed_loaded$label_col)
  expect_null(axed_loaded$features_col)
  expect_null(axed_loaded$response)
  expect_null(axed_loaded$index_labels)
  axed_loaded <- axe_data(spark_fit_loaded)
  expect_null(axed_loaded$dataset)
  axed_loaded <- axe_fitted(spark_fit_loaded)
  expect_null(axed_loaded$coefficients)
  # Butcher
  axed_loaded <- butcher(spark_fit_loaded)
  expect_equal(axed_loaded, spark_fit_loaded)
})

test_that("spark linear_reg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("sparklyr")
  skip_if_not_installed("dplyr")
  skip_if_not_installed("parsnip")
  # Load
  library(sparklyr)
  library(dplyr)
  library(parsnip)
  # Create connection
  sc <- testthat_spark_connection()
  # Data
  iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
    sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
  train <- iris_tbls$train
  validation <- iris_tbls$validation
  # Model
  reg_spark <- linear_reg() %>%
    set_engine("spark") %>%
    fit(Petal_Width ~ ., data = train)
  expected_output <- ml_predict(reg_spark$fit, validation) %>%
    select(prediction) %>%
    collect()
  x <- butcher(reg_spark)
  output <- ml_predict(x$pipeline_model, validation) %>%
    select(prediction) %>%
    collect()
  expect_gt(lobstr::obj_size(reg_spark), lobstr::obj_size(x))
  expect_equal(output, expected_output)
  # Save and load
  path <- tempfile()
  ml_save(x, path, overwrite = TRUE)
  x_loaded <- ml_load(sc, path)
  path <- tempfile()
  ml_save(reg_spark$fit, path, overwrite = TRUE)
  spark_fit_loaded <- ml_load(sc, path)
  expected_output <- spark_fit_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  new_output <- x_loaded %>%
    ml_stages() %>%
    lapply(ml_param_map)
  expect_equal(new_output, expected_output)
  expect_equal(x_loaded$uid, spark_fit_loaded$uid)
  # Test sub axe functions
  axed_loaded <- axe_call(spark_fit_loaded)
  expect_null(axed_loaded$formula)
  axed_loaded <- axe_ctrl(spark_fit_loaded)
  expect_null(axed_loaded$label_col)
  expect_null(axed_loaded$features_col)
  expect_null(axed_loaded$response)
  expect_null(axed_loaded$index_labels)
  axed_loaded <- axe_data(spark_fit_loaded)
  expect_null(axed_loaded$dataset)
  axed_loaded <- axe_fitted(spark_fit_loaded)
  expect_null(axed_loaded$coefficients)
  # Butcher
  axed_loaded <- butcher(spark_fit_loaded)
  expect_equal(axed_loaded, spark_fit_loaded)
})
