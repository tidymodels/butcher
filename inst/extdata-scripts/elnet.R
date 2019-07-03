# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(rsample)))

# Load data
split <- initial_split(mtcars, props = 9/10)
car_train <- training(split)

# Create model and fit
elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
  set_engine("glmnet") %>%
  fit_xy(x = car_train[, 2:11], y = car_train[, 1, drop = FALSE])

# Save
save(elnet_fit, file = "inst/extdata/elnet.rda")
