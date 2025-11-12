# Axing a gam.

gam objects are created from the mgcv package.

## Usage

``` r
# S3 method for class 'gam'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'gam'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'gam'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'gam'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'gam'
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

Axed gam object.

## Examples

``` r
cars_gam <- mgcv::gam(mpg ~ s(disp, k = 3) + s(wt), data = mtcars)
cleaned_gam <- butcher(cars_gam, verbose = TRUE)
#> ✔ Memory released: 13.54 kB
#> ✖ Disabled: `print()`, `summary()`, `fitted()`, and `residuals()`
```
