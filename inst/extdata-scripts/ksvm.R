# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(kernlab)))

# Load data
data(spam)

# Create model and fit
ksvm_class <- svm_poly(mode = "classification") %>%
  set_engine("kernlab", kernel = "rbfdot") %>%
  fit(type ~ ., data = spam)

# Another model
ksvm_reg <- svm_poly(mode = "regression") %>%
  set_engine("kernlab") %>%
  fit(mpg ~ ., data = mtcars)
