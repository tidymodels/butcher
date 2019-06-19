# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(rpart)))

# Load data
set.seed(1234)
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)

# Create model and fit
rpart_fit <- decision_tree(mode = "regression") %>%
  set_engine("rpart") %>%
  fit(mpg ~ ., data = car_train,
      minsplit = 5,
      cp = 0.1)

# Save
save(rpart_fit, file = "inst/extdata/rpart.rda")
