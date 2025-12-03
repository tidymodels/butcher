# Axing a tabnet_fit.

Axing a tabnet_fit.

Remove fitted values.

## Usage

``` r
# S3 method for class '`_tabnet_fit`'
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

Axed tabnet_fit object.

## Examples

``` r
# Load libraries
suppressWarnings(suppressMessages(library(parsnip)))
suppressWarnings(suppressMessages(library(rsample)))

# Load data
split <- initial_split(mtcars, props = 9/10)
#> Error in initial_split(mtcars, props = 9/10): `...` must be empty.
#> ✖ Problematic argument:
#> • props = 9/10
car_train <- training(split)
#> Error in training(split): No method for objects of class: function

# Create model and fit
mtcar_fit <- tabnet() %>%
  set_mode("regression") %>%
  set_engine("torch")
#> Error in tabnet(): could not find function "tabnet"
  fit(mpg ~ ., data = car_train)
#> Error in UseMethod("fit"): no applicable method for 'fit' applied to an object of class "formula"

out <- butcher(mtcar_fit, verbose = TRUE)
#> Error: object 'mtcar_fit' not found
```
