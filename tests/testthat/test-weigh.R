context("weigh")

test_that("weigh() recursively measures size of each object component", {
  simulate_x <- matrix(runif(1e+6), ncol = 2)
  simulate_y <- runif(dim(simulate_x)[1])
  lm_out <- lm(simulate_y ~ simulate_x)
  object_sizes <- weigh(lm_out)
  expect_equal(dim(object_sizes)[2], 2)
  expect_gt(round(object_sizes$size[1]), 44) # TODO: write a smarter test
})


test_that("checking internal lm_fit test object", {
  skip_on_cran()
  lm_fit <- lm(mpg ~ ., data = mtcars)
  expect_equal(dim(weigh(lm_fit, 0))[1], 25)
})

test_that("checking internal stanreg test object", {
  skip_on_cran()
  skip_if_not_installed("rstanarm")
  skip_if_not_installed("parsnip")
  library(parsnip)
  ctrl <- fit_control(verbosity = 0) # Avoid printing output
  stanreg_fit <- linear_reg() %>%
    set_engine("stan") %>%
    fit(mpg ~ ., data = mtcars, control = ctrl)
  stan_weights <- weigh(stanreg_fit, 0)
  expect_true("stanfit..MISC" %in% stan_weights$object)
})

