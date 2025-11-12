# Axing a train object.

train objects are created from the caret package.

## Usage

``` r
# S3 method for class 'train'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'train'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'train'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'train'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'train'
axe_fitted(x, verbose = FALSE, ...)
```

## Arguments

- x:

  A model object.

- verbose:

  Print information each time an axe method is executed. Notes how much
  memory is released and what functions are disabled. Default is
  `FALSE`.

- ...:

  Any additional arguments related to axing.

## Value

Axed train object.

## Examples

``` r
# Load libraries
library(caret)

data(iris)
train_data <- iris[, 1:4]
train_classes <- iris[, 5]

train_fit <- train(train_data, train_classes,
                   method = "knn",
                   preProcess = c("center", "scale"),
                   tuneLength = 10,
                   trControl = trainControl(method = "cv"))

out <- butcher(train_fit, verbose = TRUE)
#> ✔ Memory released: 32.19 kB
#> ✖ Disabled: `summary()` and `update()`
```
