test_that("butchering two-way rsplits", {
  skip_if_not_installed("rsample")

  basic_split <- rsample::initial_split(mtcars)
  time_split <- rsample::initial_time_split(mtcars)
  grp_split <- rsample::group_initial_split(mtcars, cyl)

  basic_split_trim <- butcher(basic_split)
  time_split_trim <- butcher(time_split)
  grp_split_trim <- butcher(grp_split)

  expect_snapshot(print(basic_split_trim))
  expect_snapshot(print(time_split_trim))
  expect_snapshot(print(grp_split_trim))

  expect_snapshot(butcher(basic_split, verbose = TRUE))
  expect_snapshot(butcher(time_split, verbose = TRUE))
  expect_snapshot(butcher(grp_split, verbose = TRUE))
})

test_that("butchering three-way rsplits", {
  skip_if_not_installed("rsample")

  val_split <- rsample::initial_validation_split(mtcars)

  val_split_trim <- butcher(val_split)

  expect_snapshot(print(val_split_trim))

  expect_snapshot(butcher(val_split, verbose = TRUE))
})


test_that("butchering rsets", {
  skip_if_not_installed("rsample")

  set.seed(1)
  basic_rset <- rsample::vfold_cv(mtcars, v = 3)
  boot_rset <- rsample::bootstraps(mtcars, times = 2)
  time_rset <- rsample::sliding_window(mtcars, lookback = 28, assess_stop = 2)

  basic_rset_trim <- butcher(basic_rset)
  boot_rset_trim <- butcher(boot_rset)
  time_rset_trim <- butcher(time_rset)

  expect_snapshot(print(basic_rset_trim$splits))
  expect_snapshot(print(boot_rset_trim$splits))
  expect_snapshot(print(time_rset_trim$splits))

  expect_snapshot(butcher(basic_rset, verbose = TRUE))
  expect_snapshot(butcher(boot_rset, verbose = TRUE))
  expect_snapshot(butcher(time_rset, verbose = TRUE))
})

test_that("butchering tune_results", {
  skip_if_not_installed("tune")
  skip_if_not_installed("workflowsets")
  suppressPackageStartupMessages(library(tune))
  suppressPackageStartupMessages(library(workflowsets))

  load(system.file("extdata", "workflow_sets.RData", package = "butcher"))

  tune_obj <- wflow_res$result[[1]]
  tune_obj_trim <- butcher(tune_obj)

  expect_snapshot(print(tune_obj_trim$splits))

  expect_snapshot(butcher(tune_obj, verbose = TRUE))
})


test_that("butchering workflow sets", {
  skip_if_not_installed("tune")
  skip_if_not_installed("workflowsets")
  suppressPackageStartupMessages(library(tune))
  suppressPackageStartupMessages(library(workflowsets))

  load(system.file("extdata", "workflow_sets.RData", package = "butcher"))

  # prior to running workflow_map
  expect_equal(wflow_set, butcher(wflow_set))

  # after populating the 'results' column
  wflow_res_trim <- butcher(wflow_res)

  expect_snapshot(print(wflow_res_trim$result[[1]]$splits))
  expect_snapshot(print(wflow_res_trim$result[[2]]$splits))
  expect_snapshot(print(wflow_res_trim$result[[3]]$splits))

  expect_snapshot(butcher(wflow_res, verbose = TRUE))
})
