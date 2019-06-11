context("axe")

test_that("predict still works with axed lm object", {
  lm_axed <- axe(lm_fit)
  # With new data
  new_data <- head(mtcars)[,2:11]
  expect_equal(predict(lm_axed, new_data),
               predict(lm_fit$fit, new_data))
  # Without new data
  expect_equal(predict(lm_axed),
               predict(lm_fit$fit))
  # With standard errors
  expect_equal(predict(lm_axed, se.fit = TRUE),
               predict(lm_fit$fit, se.fit = TRUE))
  expect_equal(predict(lm_axed, se.fit = TRUE, scale = .5),
               predict(lm_fit$fit, se.fit = TRUE, scale = .5))
  # With intervals
  expect_equal(predict(lm_axed, interval = c("confidence")),
               predict(lm_fit$fit, interval = c("confidence")))
  expect_equal(predict(lm_axed, newdata = new_data, interval = c("confidence")),
               predict(lm_fit$fit, newdata = new_data, interval = c("confidence")))

})
