context("randomForest")

test_that("randomForest + predict() works", {
  skip_on_cran()
  skip_if_not_installed("randomForest")
  library(randomForest)
  randomForest_fit <- randomForest(mpg ~ .,
                                   data = mtcars)
  x <- axe_call(randomForest_fit)
  expect_equal(x$call, call("dummy_call"))
  x <- butcher(randomForest_fit)
  expect_equal(predict(x),
               predict(randomForest_fit))
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
