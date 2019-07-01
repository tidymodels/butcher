# Load libraries
suppressWarnings(suppressMessages(library(ipred)))

# Load data
data("GlaucomaM", package = "TH.data")

classbagg_fit <- bagging(Class ~ .,
                         data = GlaucomaM,
                         nbagg = 10,
                         coob = TRUE)

# Save
save(classbagg_fit, file = "inst/extdata/classbagg.rda")

