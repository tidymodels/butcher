# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))

# Load data
set.seed(1234)
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Create model and fit
rpart_fit <- decision_tree(mode = "regression",
                             cost_complexity = NULL,
                             tree_depth = 5,
                             min_n = 2) %>%
  set_engine("rpart") %>%
  fit(mpg ~ ., data = car_train)

# Save
save(rpart_fit, file = "inst/extdata/rpart.rda")
