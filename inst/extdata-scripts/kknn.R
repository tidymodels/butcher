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
kknn_fit <- nearest_neighbor(mode = "classification",
                             neighbors = 3,
                             weight_func = "gaussian",
                             dist_power = 2) %>%
  set_engine("kknn") %>%
  fit(Kyphosis ~ ., data = spine_train)

# Save
save(kknn_fit, file = "inst/extdata/kknn.rda")
