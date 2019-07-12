# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))

# Load data
set.seed(1234)
predictrs <- matrix(rnorm(100*20), ncol = 20)
response <- as.factor(sample(1:4, 100, replace = TRUE))

# Create model and fi
multnet_fit <- multinom_reg() %>%
  set_engine("glmnet") %>%
  fit_xy(x = predictrs, y = response)

# Save
save(multnet_fit, file = "inst/extdata/multnet.rda")

# Another example
data("lending_club")

multi_reg <- multinom_reg(penalty = 0.01) %>%
  set_engine("glmnet") %>%
  fit(verification_status ~ annual_inc + sub_grade, data = lending_club)

prediction <- multi_reg %>%
  predict(new_data = lending_club, type = "prob")

glimpse(prediction)
