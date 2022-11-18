get_toy_data <- function() {
  # example toy data taken from clustMixType::kproto
  n   <- 100
  prb <- 0.9
  muk <- 1.5

  clusid <- rep(1:4, each = n)

  x1 <- sample(c("A","B"), 2*n, replace = TRUE, prob = c(prb, 1-prb))
  x1 <- c(x1, sample(c("A","B"), 2*n, replace = TRUE, prob = c(1-prb, prb)))
  x1 <- as.factor(x1)

  x2 <- sample(c("A","B"), 2*n, replace = TRUE, prob = c(prb, 1-prb))
  x2 <- c(x2, sample(c("A","B"), 2*n, replace = TRUE, prob = c(1-prb, prb)))
  x2 <- as.factor(x2)

  x3 <- c(rnorm(n, mean = -muk), rnorm(n, mean = muk), rnorm(n, mean = -muk), rnorm(n, mean = muk))
  x4 <- c(rnorm(n, mean = -muk), rnorm(n, mean = muk), rnorm(n, mean = -muk), rnorm(n, mean = muk))

  data.frame(x1,x2,x3,x4)
}
toy_data <- get_toy_data()
kproto_params <- list(k = 4,
                      iter.max = 1000,
                      nstart = 10,
                      lambda = 6.177876,
                      verbose = FALSE)

test_that("kproto + axe_data() works", {
  skip_if_not_installed("clustMixType")
  model <- do.call(clustMixType::kproto, c(list(x = toy_data), kproto_params))
  x <- axe_data(model)
  expect_equal(x$data, model$data[FALSE,])
})

test_that("kproto + axe_fitted() works", {
  skip_if_not_installed("clustMixType")
  model <- do.call(clustMixType::kproto, c(list(x = toy_data), kproto_params))
  x <- axe_fitted(model)
  expect_equal(x$cluster, integer(0))
  expect_equal(x$dists, model$dists[FALSE,,drop=FALSE])
})

test_that("kproto + butcher() works", {
  skip_if_not_installed("clustMixType")
  model <- do.call(clustMixType::kproto, c(list(x = toy_data), kproto_params))
  x <- butcher(model)
  expect_equal(x$data, model$data[FALSE,])
  expect_equal(x$cluster, integer(0))
  expect_equal(x$dists, model$dists[FALSE,,drop=FALSE])
})

test_that("kproto + predict() works", {
  skip_if_not_installed("clustMixType")
  model <- do.call(clustMixType::kproto, c(list(x = toy_data), kproto_params))
  x <- butcher(model)
  expect_equal(predict(x, toy_data),
               predict(model, toy_data))
})
