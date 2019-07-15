context("randomForest")

test_that("randomForest + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("randomForest.rda" %in% example_files)
  expect_true(file.exists(butcher_example("randomForest.rda")))
})


test_that("randomForest + predict() works", {
  skip_on_cran()
  skip_if_not_installed("randomForest")
  load(butcher_example("randomForest.rda"))
  x <- axe_call(randomForest_fit)
  expect_equal(x$call, call("dummy_call"))
  x <- butcher(randomForest_fit)
  expect_equal(predict(x)[1:6], structure(c(`2` = 2L, `3` = 1L, `4` = 2L, `5` = 1L, `6` = NA, `7` = NA), .Label = c("absent", "present"), class = "factor"))
  library(randomForest)
  iris.rf <- randomForest(Species ~ .,
                          data = iris,
                          importance = TRUE,
                          proximity = TRUE,
                          localImp = TRUE,
                          keep.inbag = TRUE)
  x <- axe_call(iris.rf)
  expect_equal(x$call, call("dummy_call"))
  x <- axe_ctrl(iris.rf)
  expect_equal(x$inbag, matrix(NA))
  x <- axe_env(iris.rf)
  expect_equal(attr(x$terms, ".Environment"), rlang::base_env())
  x <- butcher(iris.rf)
  expect_equal(predict(x, newdata = iris[1:3, ]),
               structure(c(`1` = 1L, `2` = 1L, `3` = 1L), .Label = c("setosa", "versicolor", "virginica"), class = "factor"))
})
