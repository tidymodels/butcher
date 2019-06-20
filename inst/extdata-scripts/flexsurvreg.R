# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(tidymodels)))
suppressWarnings(suppressMessages(library(flexsurv)))

# Create model and fit
flexsurvreg_fit <- surv_reg(mode = "regression", dist = "gengamma") %>%
  set_engine("flexsurv") %>%
  fit(Surv(Tstart, Tstop, status) ~ trans, data = bosms3)

# Save
save(flexsurvreg_fit, file = "inst/extdata/flexsurvreg.rda")
