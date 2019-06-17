# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))

# Load data
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)
car_test  <- testing(split)

# Create model and fit
ctrl <- fit_control(verbosity = 0) # Avoid printing output
stanreg_fit <- linear_reg() %>%
  set_engine("stan") %>%
  fit(mpg ~ ., data = car_train, control = ctrl)

# Save
save(stanreg_fit, file = "inst/extdata/stanreg.rda")
