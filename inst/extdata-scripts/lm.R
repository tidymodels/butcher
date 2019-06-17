# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))

# Load data
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Create model and fit
lm_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = car_train)

# Save
save(lm_fit, file = "inst/extdata/lm.rda")
