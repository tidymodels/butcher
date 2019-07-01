context("stanreg")

# Stan objects are too large create on the fly

# test_that("stanreg + butcher_example() works", {
#   example_files <- butcher_example()
#   expect_true("stanreg.rda" %in% example_files)
#   expect_true(file.exists(butcher_example("stanreg.rda")))
# })

# load(butcher_example("stanreg.rda"))

test_that("stanreg + butcher() works", {
  skip_on_cran()
  skip_if_not_installed("rstanarm")
  skip_if_not_installed("parsnip")
  library(parsnip)
  ctrl <- fit_control(verbosity = 0) # Avoid printing output
  stanreg_fit <- linear_reg() %>%
    set_engine("stan") %>%
    fit(mpg ~ ., data = mtcars, control = ctrl)
  x <- butcher(stanreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(attributes(x$model)$terms, ".Environment"), rlang::base_env())
  expect_identical(x$stanfit@.MISC, rlang::empty_env())
  expect_identical(x$stanfit@stanmodel@dso@.CXXDSOMISC, rlang::empty_env())
  expect_equal(x$fitted.values, numeric(0))
  expect_equal(class(x)[1], "butchered_stanreg")
  expected_output <- predict(stanreg_fit$fit)
  expect_equal(predict(x), expected_output)
})
