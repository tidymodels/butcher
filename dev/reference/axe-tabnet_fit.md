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
suppressWarnings(suppressMessages(library(tabnet)))

# Load data
split <- initial_split(mtcars, prop = 9/10)
car_train <- training(split)

# Create model and fit
mtcar_fit <- tabnet() %>%
  set_mode("regression") %>%
  set_engine("torch") %>%
  fit(mpg ~ ., data = car_train)
#> Error in cpp_torch_manual_seed(as.character(seed)): Lantern is not loaded. Please use `install_torch()` to install additional dependencies.

out <- butcher(mtcar_fit, verbose = TRUE)
#> Error: object 'mtcar_fit' not found
```
