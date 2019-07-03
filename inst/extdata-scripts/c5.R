# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(rsample)))
suppressWarnings(suppressMessages(library(rpart)))

# Load data
set.seed(1234)
split <- initial_split(kyphosis, props = 9/10)
spine_train <- training(split)

# Create model and fit
c5_fit <- decision_tree(mode = "classification") %>%
  set_engine("C5.0") %>%
  fit(Kyphosis ~ ., data = spine_train)

# Save
save(c5_fit, file = "inst/extdata/c5.rda")

# Another example
boost_fit <- boost_tree(mode = "classification", trees = 15) %>%
  set_engine("C5.0") %>%
  fit(Species ~ ., data = iris)

# Save
save(boost_fit, file = "inst/extdata/c5_boost.rda")

