test_that("gausspr + predict() works", {
  skip_on_cran()
  skip_if_not_installed("kernlab")
  # Load
  suppressPackageStartupMessages(library(kernlab))
  test <- gausspr(Species ~ .,
                  data = iris,
                  var = 2,
                  kpar = list(sigma = 2))
  x <- axe_call(test)
  expect_equal(x@kcall, rlang::expr(dummy_call()))
  x <- axe_env(test)
  expect_identical(attr(x@terms, ".Environment"),
                   rlang::base_env())
  x <- axe_data(test)
  expect_equal(x@ymatrix, NULL)
  x <- axe_fitted(test)
  expect_equal(x@fitted, numeric(0))
  x <- butcher(test)
  expect_equal(attr(x, "butcher_disabled"),
               c("print()", "summary()", "fitted()"))
  expect_equal(predict(x, iris[1:3, ]),
               predict(test, iris[1:3, ]))
})
