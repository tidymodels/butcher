# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))

# Load data
set.seed(1234)
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Create model and fit
rpart_fit <- decision_tree(mode = "regression") %>%
  set_engine("rpart") %>%
  fit(mpg ~ ., data = car_train)

library(rpart)
 predict(rpart_fit, new_data = mtcars)
predict(rpart_fit$fit)
 sloop::s3_dispatch(predict(rpart_fit$fit))

# Save
save(rpart_fit, file = "inst/extdata/rpart.rda")
