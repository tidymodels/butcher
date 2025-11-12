# Axing an ranger.

ranger objects are created from the ranger package, which is used as a
means to quickly train random forests. The package supports ensembles of
classification, regression, survival and probability prediction trees.
Given the reliance of post processing functions on the model object,
like `importance_pvalues` and `treeInfo`, on the first class listed, the
`butcher_ranger` class is not appended.

## Usage

``` r
# S3 method for class 'ranger'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'ranger'
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

Axed ranger object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)
library(ranger)
#> 
#> Attaching package: ‘ranger’
#> The following object is masked from ‘package:randomForest’:
#> 
#>     importance

# Load data
set.seed(1234)
split <- initial_split(iris, prop = 9/10)
iris_train <- training(split)

# Create model and fit
ranger_fit <- rand_forest(mode = "classification",
                          mtry = 2,
                          trees = 20,
                          min_n = 3) %>%
  set_engine("ranger") %>%
  fit(Species ~ ., data = iris_train)

out <- butcher(ranger_fit, verbose = TRUE)
#> ✖ The butchered object is 1.21 kB larger than the original. Do not butcher.

# Another ranger object
wrapped_ranger <- function() {
  n <- 100
  p <- 400
  dat <- data.frame(y = factor(rbinom(n, 1, .5)), replicate(p, runif(n)))
  fit <- ranger(y ~ ., dat, importance = "impurity_corrected")
  return(fit)
}

cleaned_ranger <- axe_fitted(wrapped_ranger(), verbose = TRUE)
#> ✔ Memory released: 448 B
#> ✖ Disabled: `predictions()`
#> ✖ Could not add <butchered> class
```
