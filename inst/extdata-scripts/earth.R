# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))

# Create model and fit
earth_fit <- mars(mode = "regression") %>%
  set_engine("earth") %>%
  fit(Volume ~ ., data = trees)
