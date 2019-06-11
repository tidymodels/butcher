context("axe")

new_data <- head(mtcars)[, 2:11]

test_that("predict still works with axed lm object", {
  lm_axed <- axe(lm_fit)
  # With new data
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


test_that("predict still works with axed glmnet object", {
  glm_axed <- axe(glmnet_fit)
  # Reformat the testing data for consumption
  new_data <- model.matrix(~.-1, data = new_data)
  expect_equal(predict.glmnet(glm_axed, new_data),
               predict.glmnet(glmnet_fit$fit, new_data))
  expect_equal(predict.glmnet(glm_axed, new_data, s = .1, exact = TRUE),
               predict.glmnet(glmnet_fit$fit, new_data, s = .1, exact = TRUE))
  # Model object has to work with `update(object, lambda = lambda..)`
})

test_that("axed objects addresses the heaviest components from weigh()", {
})
