# Axing an randomForest.

randomForest objects are created from the `randomForest` package, which
is used to train random forests based on Breiman's 2001 work. The
package supports ensembles of classification and regression trees.

## Usage

``` r
# S3 method for class 'randomForest'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'randomForest'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'randomForest'
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

Axed randomForest object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)
library(randomForest)
#> randomForest 4.7-1.2
#> Type rfNews() to see new features/changes/bug fixes.
#> 
#> Attaching package: ‘randomForest’
#> The following object is masked from ‘package:ggplot2’:
#> 
#>     margin
data(kyphosis, package = "rpart")

# Load data
set.seed(1234)
split <- initial_split(kyphosis, prop = 9/10)
spine_train <- training(split)

# Create model and fit
randomForest_fit <- rand_forest(mode = "classification",
                                mtry = 2,
                                trees = 2,
                                min_n = 3) %>%
  set_engine("randomForest") %>%
  fit_xy(x = spine_train[,2:4], y = spine_train$Kyphosis)

out <- butcher(randomForest_fit, verbose = TRUE)
#> ✔ Memory released: 192 B

# Another randomForest object
wrapped_rf <- function() {
  some_junk_in_environment <- runif(1e6)
  randomForest_fit <- randomForest(mpg ~ ., data = mtcars)
  return(randomForest_fit)
}

# Remove junk
cleaned_rf <- axe_env(wrapped_rf(), verbose = TRUE)
#> ✔ Memory released: 9.51 MB

# Check size
lobstr::obj_size(cleaned_rf)
#> 428 kB
```
