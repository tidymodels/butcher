context("survreg")

test_that("survreg + butcher_example() works", {
  example_files <- butcher_example()
  expect_true("survreg.rda" %in% example_files)
  expect_true(file.exists(butcher_example("survreg.rda")))
})

test_that("survreg + predict() works", {
  skip_on_cran()
  skip_if_not_installed("survival")
  load(butcher_example("survreg.rda"))
  x <- butcher(survreg_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$y, numeric(0))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(predict(x, ovarian[1, 1:2])[1], c(`1` = 1225.4189589287))
  expect_equal(predict(survreg_fit$fit, newdata = ovarian[1, 1:2], type = c("quantile")), c(160.794978494583, 2601.21611951026))
  expect_equal(predict(survreg_fit$fit, newdata = ovarian[1, 1:2], type = c("linear")), c(`1` = 7.1110380717964))
  expect_equal(predict(survreg_fit$fit, newdata = ovarian[1, 1:2], se.fit = TRUE)$se.fit, c(`1` = 358.714386983321))
})
