context("carve")

test_that("carve() strips out the environment", {
  lm_fit_parsed <- carve(lm_fit)
  expect_null(attr(lm_fit_parsed$term, ".Environment"))
})
