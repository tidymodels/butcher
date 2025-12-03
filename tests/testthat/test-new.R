test_that("new_model_butcher", {
  expect_snapshot(
    new_model_butcher("potato", "Potato"),
    error = TRUE
  )

  expect_snapshot(
    new_model_butcher("poe TAY toe", "Potato"),
    error = TRUE
  )

  expect_snapshot(
    new_model_butcher(1, "Potato"),
    error = TRUE
  )
})
