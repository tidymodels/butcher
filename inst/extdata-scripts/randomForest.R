# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(rpart)))

# Load data
set.seed(1234)
split <- initial_split(kyphosis, props = 9/10)
spine_train <- training(split)

# Create model and fit
randomForest_fit <- rand_forest(mode = "classification",
                      mtry = 2,
                      trees = 2,
                      min_n = 3) %>%
  set_engine("randomForest") %>%
  fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)

# Save
save(randomForest_fit, file = "inst/extdata/randomForest.rda")
