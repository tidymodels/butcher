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

# Another model
suppressWarnings(suppressMessages(library(caret)))
data(GermanCredit)

stanlog_fit <- logistic_reg() %>%
  set_engine(
    "stan",
    iter = 5000,
    seed = 2347
  ) %>%
  fit(Class ~ Age + ForeignWorker + Property.RealEstate + CreditHistory.Critical,
      data = GermanCredit)

# Save
# save(stanlog_fit, file = "inst/extdata/stanlog.rda")
