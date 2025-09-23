skip_if_not_installed("MASS")
library(MASS)

test_that("polr + axe_env() works", {
  housing <- MASS::housing
  res <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)

  x <- axe_env(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
})

test_that("polr + butcher() works", {
  housing <- MASS::housing
  res <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)

  x <- butcher(res)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(class(x)[1], "butchered_polr")
})

test_that("polr + predict() works", {
  housing <- MASS::housing
  res <- polr(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)

  x <- butcher(res)
  expect_equal(
    predict(x, newdata = head(housing))[1],
    predict(res, newdata = head(housing))[1]
  )
})
