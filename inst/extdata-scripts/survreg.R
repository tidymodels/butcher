# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(flexsurv)))

# Create model and fit
survreg_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
  set_engine("survreg") %>%
  fit(Surv(futime, fustat) ~ 1, data = ovarian)

# Save
save(survreg_fit, file = "inst/extdata/survreg.rda")
