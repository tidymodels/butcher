context("axe_ctrl")

test_that("axe_ctrl() works", {
  # RPART
  treereg_axed <- axe_ctrl(treereg_fit)
  expect_null(treereg_axed$control)
  # C50
  treeC5_axed <- axe_ctrl(treeC5_fit)
  expect_null(treeC5_axed$control)

})
