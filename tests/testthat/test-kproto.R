skip_if_not_installed("clustMixType")
skip_if_not_installed("modeldata")

data(crickets, package = "modeldata")
## this model does not work with tibble input:
crickets <- as.data.frame(crickets)

test_that("kproto + axe_data() works", {
  kp_fit <- clustMixType::kproto(crickets, k = 3, verbose = FALSE)
  x <- axe_data(kp_fit)
  expect_equal(x$data, data.frame(NA))
})

test_that("kproto + axe_fitted() works", {
  kp_fit <- clustMixType::kproto(crickets, k = 3, verbose = FALSE)
  x <- axe_fitted(kp_fit)
  expect_equal(x$cluster, integer(0))
  expect_equal(x$dists, matrix(NA_real_))
})

test_that("kproto + butcher() works", {
  kp_fit <- clustMixType::kproto(crickets, k = 3, verbose = FALSE)
  x <- butcher(kp_fit)
  expect_equal(x$data, data.frame(NA))
  expect_equal(x$cluster, integer(0))
  expect_equal(x$dists, matrix(NA_real_))
})

test_that("kproto + predict() works", {
  kp_fit <- clustMixType::kproto(crickets, k = 3, verbose = FALSE)
  x <- butcher(kp_fit)
  expect_equal(predict(x, crickets[1:2,]),
               predict(kp_fit, crickets[1:2,]))
})
