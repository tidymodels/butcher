test_that("Generate expected UI messages", {
  big <- runif(1e4)
  big <- add_butcher_class(big)
  small <- runif(1e3)
  small <- add_butcher_class(small)
  obj_size_diff <- lobstr::obj_size(big) - lobstr::obj_size(small)
  obj_size_diff <- format(obj_size_diff, big.mark = ",", scientific = FALSE)

  expect_snapshot(
    {
      assess_object(big, small)
      assess_object(small, small)
      assess_object(small, big)
    },
    transform = function(x) gsub(obj_size_diff, "<redacted>", x, fixed = TRUE)
  )
})
