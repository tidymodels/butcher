# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(rsample)))
suppressWarnings(suppressMessages(library(survival)))
suppressWarnings(suppressMessages(library(flexsurv)))

# Create model and fit
flexsurvreg_fit <- surv_reg(mode = "regression", dist = "exp") %>%
  set_engine("flexsurv") %>%
  fit(Surv(futime, fustat) ~ age, data = ovarian)

# Save
save(flexsurvreg_fit, file = "inst/extdata/flexsurvreg.rda")

# Semi Markov model
flexsurvreg_markov_fit <- surv_reg(mode = "regression", dist = "weibull") %>%
  set_engine("flexsurv") %>%
  fit(Surv(years, status) ~ trans + shape(trans), data = bosms3)

# Save
save(flexsurvreg_markov_fit, file = "inst/extdata/flexsurvreg_markov.rda")

# Flexsurvreg model with custom distribution
custom.llogis <- list(name = "llogis",
                      pars = c("shape", "scale"),
                      location = "scale",
                      transforms = c(log, log),
                      inv.transforms = c(exp, exp),
                      inits = function(t){ c(1, median(t)) })
flexsurvreg_custom_fit <- flexsurvreg(Surv(recyrs, censrec) ~ group,
                                      data = bc,
                                      dist = custom.llogis)

# Save
save(flexsurvreg_custom_fit, file = "inst/extdata/flexsurvreg_custom.rda")
