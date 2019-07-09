context("spark")

source("utils.R")

test_that("spark ml_model + predict() works", {
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
  # Model
  spark_fit <- ml_logistic_regression(train, Species ~ .)
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
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
})
