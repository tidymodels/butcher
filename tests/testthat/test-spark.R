context("spark")

library(sparklyr)
library(dplyr)
sc <- spark_connect(master = "local")

# Testing data
iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
  sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)
validation <- iris_tbls$validation


test_that("spark + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("spark.rda" %in% example_files)
  expect_true(file.exists(butcher_example("spark.rda")))
})

test_that("spark ml_model + predict() works", {
  spark_fit <- ml_load(sc, path = butcher_example("spark.rda"))
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
  x <- butcher(spark_fit)
  output <- ml_predict(x, validation) %>%
    select(predicted_label) %>%
    collect()
  expect_equal(output, expected_output)
})

test_that("spark decision_tree + predict() works", {
  spark_fit <- ml_load(sc, path = butcher_example("decision_spark.rda"))
  expected_output <- ml_predict(spark_fit, validation) %>%
    select(predicted_label) %>%
    collect()
  x <- butcher(spark_fit)
  expect_identical(rlang::get_env(x$stages[[2]]$feature_importances), rlang::empty_env())
  expect_identical(rlang::get_env(x$stages[[2]]$depth), rlang::empty_env())
  expect_identical(rlang::get_env(x$stages[[2]]$num_nodes), rlang::empty_env())
  output <- ml_predict(x, validation) %>%
    select(predicted_label) %>%
    collect()
  expect_equal(output, expected_output)
})
