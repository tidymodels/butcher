skip_if_not_installed("mgcv")

test_that("gam + axe_call() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- axe_call(gam_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
})

test_that("gam + axe_ctrl() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- axe_ctrl(gam_fit)
  expect_equal(x$control, list())
})

test_that("gam + axe_env() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- axe_env(gam_fit)
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$pterms, ".Environment"), rlang::base_env())
  expect_identical(attr(x$formula, ".Environment"), rlang::base_env())
})

test_that("gam + axe_fitted() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- axe_fitted(gam_fit)
  expect_equal(x$fitted.values, numeric(0))
})

test_that("gam + butcher() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- butcher(gam_fit)
  expect_equal(x$call, rlang::expr(dummy_call()))
  expect_identical(attr(x$terms, ".Environment"), rlang::base_env())
  expect_equal(x$fitted.values, numeric(0))
  expect_equal(class(x)[1], "butchered_gam")
})

test_that("gam + predict() works", {
  gam_fit <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
  x <- butcher(gam_fit)
  expect_equal(
    predict(x, newdata = head(mtcars))[1],
    predict(gam_fit, newdata = head(mtcars))[1]
  )
  expect_equal(
    predict(x, newdata = head(mtcars), type = "terms")[1, ],
    predict(gam_fit, newdata = head(mtcars), type = "terms")[1, ]
  )
  expect_equal(
    predict(x, newdata = head(mtcars), se.fit = TRUE)$se.fit[1],
    predict(gam_fit, newdata = head(mtcars), se.fit = TRUE)$se.fit[1]
  )
})

test_that("gam + predict() works with offset", {
  gam_fit <- mgcv::gam(
    mpg ~ s(disp, k = 3) + s(wt),
    data = mtcars,
    offset = seq(1, nrow(mtcars))
  )
  x <- butcher(gam_fit)
  expect_equal(
    predict(x, newdata = head(mtcars))[1],
    predict(gam_fit, newdata = head(mtcars))[1]
  )
  expect_equal(
    predict(x, newdata = head(mtcars), type = "terms")[1, ],
    predict(gam_fit, newdata = head(mtcars), type = "terms")[1, ]
  )
  expect_equal(
    predict(x, newdata = head(mtcars), se.fit = TRUE)$se.fit[1],
    predict(gam_fit, newdata = head(mtcars), se.fit = TRUE)$se.fit[1]
  )
})
