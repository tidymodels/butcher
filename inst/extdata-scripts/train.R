# Load libraries
suppressWarnings(suppressMessages(library(caret)))

data(iris)
train_data <- iris[, 1:4]
train_classes <- iris[, 5]

train_fit <- train(train_data, train_classes,
                   method = "knn",
                   preProcess = c("center", "scale"),
                   tuneLength = 10,
                   trControl = trainControl(method = "cv"))

# Save
save(train_fit, file = "inst/extdata/train.rda")
