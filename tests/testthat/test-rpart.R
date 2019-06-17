context("rpart")

test_that("rpart + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("rpart.rda" %in% example_files)
  expect_true(file.exists(butcher_example("rpart.rda")))
})

load(butcher_example("rpart.rda"))

test_that("rpart + axe() works", {
  x <- axe(rpart_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$functions, rlang::expr(dummy_call()))
  expect_equal(x$control, list(NULL))
  expect_identical(attr(x$terms, ".Environment"), rlang::empty_env())
  expect_equal(class(x), "butcher_rpart")
})

test_that("rpart + predict() works", {
  x <- axe(rpart_fit)
  # TODO: Figure out how to get this predict.rpart to work
  # expect_gt(predict(x)[1], 20)
})

