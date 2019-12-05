context("example")

test_that("default example is returned", {
  expected_file <- dir(system.file("extdata", package = "butcher"))
  expect_equal(butcher_example(NULL), expected_file)
})
