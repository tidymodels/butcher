# Load libraries
suppressWarnings(suppressMessages(library(ipred)))
suppressWarnings(suppressMessages(library(rpart)))
suppressWarnings(suppressMessages(library(MASS)))

# Load data
data("GlaucomaM", package = "TH.data")

classbagg_fit <- bagging(Class ~ .,
                         data = GlaucomaM,
                         nbagg = 10,
                         coob = TRUE)

# Save
save(classbagg_fit, file = "inst/extdata/classbagg.rda")

