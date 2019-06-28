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
#   sc <- testthat_spark_connection() # TODO: figure out whether worth
#   # sc <- spark_connect(master = "local")
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   # Model
#   spark_fit <- ml_logistic_regression(train, Species ~ .)
#   # spark_fit <- ml_load(sc, path = butcher_example("spark.rda"))
#   expected_output <- ml_predict(spark_fit, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   # Butcher
#   # x <- butcher(spark_fit)
#   # class(x) <- class(spark_fit)
#   # output <- ml_predict(x, validation) %>%
#   #   select(predicted_label) %>%
#   #   collect()
#   # expect_equal(output, expected_output)
#   expect_equal(expected_output$predicted_label[1], "setosa")
# })

# test_that("spark decision_tree + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   library(parsnip)
#   # Create connection
#   # sc <- testthat_spark_connection() # TODO: figure out whether worth
#   sc <- spark_connect(master = "local")
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   # Model
#   decision_spark <- decision_tree(mode = "classification") %>%
#     set_engine("spark") %>%
#     fit(Species ~ ., data = train)
#   # spark_fit <- ml_load(sc, path = butcher_example("decision_spark.rda"))
#   expected_output <- ml_predict(decision_spark, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   x <- butcher(decision_spark)
#   expect_identical(rlang::get_env(x$stages[[2]]$feature_importances), rlang::base_env())
#   expect_identical(rlang::get_env(x$stages[[2]]$depth), rlang::base_env())
#   expect_identical(rlang::get_env(x$stages[[2]]$num_nodes), rlang::base_env())
#   output <- ml_predict(x, validation) %>%
#     select(predicted_label) %>%
#     collect()
#   expect_equal(output, expected_output)
# })
#
# test_that("spark boost_tree + predict() works", {
#   skip_on_cran()
#   skip_if_not_installed("sparklyr")
#   skip_if_not_installed("dplyr")
#   # Load
#   library(sparklyr)
#   library(dplyr)
#   library(parsnip)
#   # Create connection
#   # sc <- testthat_spark_connection() # TODO: figure out whether worth
#   sc <- spark_connect(master = "local")
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
#   # spark_fit <- ml_load(sc, path = butcher_example("boost_spark.rda"))
#   expected_output <- ml_predict(boost_spark, iris_bin_tbls) %>%
#     select(predicted_label) %>%
#     collect()
#   x <- butcher(boost_spark)
#   expect_identical(rlang::get_env(x$stages[[2]]$feature_importances), rlang::base_env())
#   expect_identical(rlang::get_env(x$stages[[2]]$trees), rlang::base_env())
#   expect_identical(rlang::get_env(x$stages[[2]]$total_num_nodes), rlang::base_env())
#   output <- ml_predict(x, iris_bin_tbls) %>%
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
#   # Data
#   iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
#     sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
#   train <- iris_tbls$train
#   validation <- iris_tbls$validation
#   # Model
#   reg_spark <- linear_reg() %>%
#     set_engine("spark") %>%
#     fit(Petal_Width ~ ., data = iris_parsed_tbls)
#   # spark_fit <- ml_load(sc, path = butcher_example("reg_spark.rda"))
#   expected_output <- ml_predict(reg_spark, iris_parsed_tbls) %>%
#     select(prediction) %>%
#     collect()
#   x <- butcher(reg_spark)
#   expect_null(x$stages[[2]]$.jobj)
#   output <- ml_predict(x, iris_parsed_tbls) %>%
#     select(prediction) %>%
#     collect()
#   expect_equal(output, expected_output)
# })
