# Axing an elnet.

elnet objects are created from the glmnet package, leveraged to fit
generalized linear models via penalized maximum likelihood.

## Usage

``` r
# S3 method for class 'elnet'
axe_call(x, verbose = FALSE, ...)
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

Axed model object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)

# Load data
split <- initial_split(mtcars, prop = 9/10)
car_train <- training(split)

# Create model and fit
elnet_fit <- linear_reg(mixture = 0, penalty = 0.1) %>%
  set_engine("glmnet") %>%
  fit_xy(x = car_train[, 2:11], y = car_train[, 1, drop = FALSE])

out <- butcher(elnet_fit, verbose = TRUE)
#> ✔ Memory released: 312 B
```
