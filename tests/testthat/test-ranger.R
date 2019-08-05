context("ranger")

test_that("ranger + importance() works", {
  skip_if_not_installed("ranger")
  library(ranger)
  n <- 50
  p <- 400
  dat <- data.frame(y = factor(rbinom(n, 1, .5)), replicate(p, runif(n)))
  rf.sim <- ranger(y ~ ., dat, importance = "impurity_corrected")
  expected_outcome <- importance_pvalues(rf.sim, method = "janitza")
  x <- axe_call(rf.sim)
  expect_equal(x$call, rlang::expr(dummy_call()))
  x <- axe_fitted(x)
  expect_equal(x$predictions, numeric(0))
  expect_equal(importance_pvalues(x, method = "janitza"), expected_outcome)
  expected_outcome <- importance(rf.sim)
  expect_equal(importance(x), expected_outcome)
})

test_that("ranger + treeInfo() works ", {
  skip_if_not_installed("ranger")
  library(ranger)
  rf.iris <- ranger(Species ~ ., data = iris, importance = "permutation")
  set.seed(123)
  expected_outcome <- importance_pvalues(rf.iris, method = "altmann",
                                         num.permutations = 10,
                                         formula = Species ~ .,
                                         data = iris)
  x <- butcher(rf.iris)
  set.seed(123)
  expect_equal(importance_pvalues(x, method = "altmann",
                                  num.permutations = 10,
                                  formula = Species ~ .,
                                  data = iris), expected_outcome)
  expected_outcome <- treeInfo(rf.iris, tree = 1)
  expect_equal(treeInfo(x, tree = 1), expected_outcome)
  expect_equal(predict(x, data = iris[1:3,], predict.all = TRUE),
               predict(rf.iris, data = iris[1:3,], predict.all = TRUE))
})


test_that("ranger + quantiles option works ", {
  skip_if_not_installed("ranger")
  library(ranger)
  rf <- ranger(mpg ~ ., data = mtcars, quantreg = TRUE)
  expected_outcome <- predict(rf, mtcars[27:32, ], type = "quantiles")
  x <- butcher(rf)
  expect_equal(predict(x, mtcars[27:32, ], type = "quantiles"),
               expected_outcome)
})

test_that("ranger + survival option works", {
  skip_if_not_installed("ranger")
  skip_if_not_installed("survival")
  library(ranger)
  library(survival)
  data(veteran)
  rg.veteran <- ranger(Surv(time, status) ~ ., data = veteran)
  x <- butcher(rg.veteran)
  expect_equal(timepoints(x),
               timepoints(rg.veteran))
})
