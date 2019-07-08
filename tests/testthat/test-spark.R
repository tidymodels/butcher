context("spark")

source("utils.R")

# Spark objects take up too much memory, just create objects on the fly..

# test_that("spark + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("spark.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("spark.rda")))
# })

# test_that("spark ml_model + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   # Create connection
#   sc <- testthat_spark_connection()
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   # Model
#   spark_fit <- ml_logistic_regression(train, Species ~ .)
#   expected_output <- ml_predict(spark_fit, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   # Butcher
#   x <- butcher(spark_fit)
#   output <- ml_predict(x, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   expect_equal(output, expected_output)
#   expect_equal(expected_output$predicted_label[1], "setosa")
# })
#
# test_that("spark decision_tree + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   library(parsnip)
#   # Create connection
#   sc <- testthat_spark_connection()
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   spark_fit <- ml_decision_tree_classifier(train, Species ~ .)
#   expected_output <- ml_predict(spark_fit, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   # Butcher
#   x <- butcher(spark_fit) # TODO: create test scaffold for ml_save ml_load since different?
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$feature_importances), rlang::empty_env())
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$depth), rlang::base_env())
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$num_nodes), rlang::base_env())
#   output <- ml_predict(x, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   expect_equal(output, expected_output)
# })

# test_that("spark boost_tree + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   library(parsnip)
#   # Create connection
#   sc <- testthat_spark_connection()
#   # Binary classification data
#   iris_bin <- iris[iris$Species != "setosa", ]
#   iris_bin$Species <- factor(iris_bin$Species)
#   iris_bin_tbls <- sdf_copy_to(sc, iris_bin, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_bin_tbls$train
#   validation <- iris_bin_tbls$validation
#   # Model
#   set.seed(1234)
#   boost_spark <- boost_tree(mode = "classification", trees = 15) %>%
#     set_engine("spark") %>%
#     fit(Species ~ ., data = train)
#   expected_output <- ml_predict(boost_spark$fit, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   x <- butcher(boost_spark)
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$feature_importances), rlang::base_env())
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$trees), rlang::base_env())
#   expect_identical(rlang::get_env(x$pipeline_model$stages[[2]]$total_num_nodes), rlang::base_env())
#   output <- ml_predict(x, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   expect_equal(output, expected_output)
# })
#
# test_that("spark linear_reg + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   library(parsnip)
#   # Create connection
#   sc <- testthat_spark_connection() # TODO: figure out whether worth
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   # Model
#   reg_spark <- linear_reg() %>%
#     set_engine("spark") %>%
#     fit(Petal_Width ~ ., data = train)
#   expected_output <- ml_predict(reg_spark$fit, validation) %>%
#     select(prediction) %>%
#     collect()
#   x <- butcher(reg_spark)
#   expect_null(x$pipeline_model$stages[[2]]$.jobj)
#   output <- ml_predict(x, validation) %>%
#     select(prediction) %>%
#     collect()
#   expect_equal(output, expected_output)
# })
