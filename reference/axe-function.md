# Axing functions.

Functions stored in model objects often have heavy environments and
bytecode attached. To avoid breaking any post-estimation functions on
the model object, the `butchered_function` class is not appended.

## Usage

``` r
# S3 method for class '`function`'
axe_env(x, verbose = FALSE, ...)
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

Axed function.

## Examples

``` r
# Load libraries
library(caret)
#> Loading required package: ggplot2
#> Loading required package: lattice
#> 
#> Attaching package: ‘caret’
#> The following object is masked from ‘package:survival’:
#> 
#>     cluster
#> The following object is masked from ‘package:rsample’:
#> 
#>     calibration

data(iris)
train_data <- iris[, 1:4]
train_classes <- iris[, 5]

train_fit <- train(train_data, train_classes,
                   method = "knn",
                   preProcess = c("center", "scale"),
                   tuneLength = 10,
                   trControl = trainControl(method = "cv"))

out <- axe_env(train_fit$modelInfo$prob, verbose = TRUE)
#> ✖ No memory released. Do not butcher.
out <- axe_env(train_fit$modelInfo$levels, verbose = TRUE)
#> ✖ No memory released. Do not butcher.
out <- axe_env(train_fit$modelInfo$predict, verbose = TRUE)
#> ✔ Memory released: 2.47 kB
#> ✖ Could not add <butchered> class
```
