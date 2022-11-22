skip_if_not_installed("ClusterR")

test_that("KMeansCluster + axe_call() works", {
  km_fit <- ClusterR::KMeans_rcpp(mtcars, clusters = 2, num_init = 5)
  x <- axe_call(km_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("KMeansCluster + axe_fitted() works", {
  km_fit <- ClusterR::KMeans_rcpp(mtcars, clusters = 2, num_init = 5)
  x <- axe_fitted(km_fit)
  expect_equal(x$clusters, numeric(0))
})

test_that("KMeansCluster + butcher() works", {
  km_fit <- ClusterR::KMeans_rcpp(mtcars, clusters = 2, num_init = 5)
  x <- butcher(km_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_equal(x$clusters, numeric(0))
  expect_equal(class(x)[1], "butchered_KMeansCluster")
})

test_that("KMeansCluster + predict() works", {
  km_fit <- ClusterR::KMeans_rcpp(mtcars, clusters = 2, num_init = 5)
  x <- butcher(km_fit)
  expect_equal(
    predict(x, newdata = head(mtcars))[1],
    predict(km_fit, newdata = head(mtcars))[1]
  )
})
