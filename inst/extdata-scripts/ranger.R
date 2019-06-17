# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(rpart)))

# Load data
set.seed(1234)
split <- initial_split(kyphosis, props = 9/10)
spine_train <- training(split)
spine_test  <- testing(split)

# Create model and fit
ranger_fit <- rand_forest(mode = "classification",
                                mtry = 2,
                                trees = 2,
                                min_n = 3) %>%
  set_engine("ranger") %>%
  fit(Kyphosis ~ ., data = spine_train)

# Save
save(ranger_fit, file = "inst/extdata/ranger.rda")
