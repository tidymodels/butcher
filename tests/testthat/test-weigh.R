context("weigh")

test_that("weigh() recursively measures size of each object component", {
  simulate_x <- matrix(runif(1e+6), ncol = 2)
  simulate_y <- runif(dim(simulate_x)[1])
  lm_out <- lm(simulate_y ~ simulate_x)
  object_sizes <- weigh(lm_out)
  expect_equal(dim(object_sizes)[2], 2)
  expect_gt(round(object_sizes$size[1]), 44) # Prob not going to pass in general
})

test_that("checking internal data", {
  expect_equal(dim(butcher::weigh(lm_fit, 0))[1], 25)
  # For stan object
  stan_weights <- weigh(stan_fit, 0)
  expect_equal(stan_weights$object[1], "stanfit..MISC")
})
