test_that("Generate expected UI messages", {
  big <- runif(1e4)
  big <- add_butcher_class(big)
  small <- runif(1e3)
  small <- add_butcher_class(small)

  expect_snapshot({
    assess_object(big, small)
    assess_object(small, small)
    assess_object(small, big)
  })

})
