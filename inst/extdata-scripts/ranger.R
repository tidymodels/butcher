# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))

# Load data
set.seed(1234)
split <- initial_split(iris, props = 9/10)
iris_train <- training(split)

# Create model and fit
ranger_fit <- rand_forest(mode = "classification",
                          mtry = 2,
                          trees = 20,
                          min_n = 3) %>%
  set_engine("ranger") %>%
  fit(Species ~ ., data = iris_train)

# Save
save(ranger_fit, file = "inst/extdata/ranger.rda")
