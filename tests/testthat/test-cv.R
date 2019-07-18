context("cv.glmnet")

test_that("cv.glmnet + predict() works", {
  skip_if_not_installed("glmnet")
  library(glmnet)
  n <- 500
  p <- 30
  nzc <- trunc(p/10)
  x <- matrix(rnorm(n*p), n, p)
  beta3 <- matrix(rnorm(30), 10, nzc)
  beta3 <- rbind(beta3, matrix(0, p-10, nzc))
  f3 <- x %*% beta3
  p3 <- exp(f3)
  p3 <- p3/apply(p3, 1, sum)
  g3 <- rmult(p3)
  set.seed(10101)
  cvfit <- cv.glmnet(x, g3, family="multinomial", keep = TRUE)
  axed_cvfit <- butcher(cvfit)
  expect_gt(lobstr::obj_size(cvfit), lobstr::obj_size(axed_cvfit))
  expected_outcome <- predict(cvfit, newx = x[1:3, ])
  expect_equal(predict(axed_cvfit, newx = x[1:3, ]), expected_outcome)
  set.seed(10101)
  cvfit2 <- cv.glmnet(x, g3, family="multinomial")
  axed_cvfit2 <- axe_fitted(cvfit2)
  expect_equal(axed_cvfit2, cvfit2)
})
