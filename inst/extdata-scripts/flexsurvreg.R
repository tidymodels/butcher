# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(flexsurv)))

# Create model and fit
flexsurvreg_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
  set_engine("flexsurv") %>%
  fit(Surv(futime, fustat) ~ 1, data = ovarian)

# Save
save(flexsurvreg_fit, file = "inst/extdata/flexsurvreg.rda")
