# Axing an earth object.

earth objects are created from the earth package, which is leveraged to
do multivariate adaptive regression splines.

## Usage

``` r
# S3 method for class 'earth'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'earth'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'earth'
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

Axed earth object.

## Examples

``` r
# Load libraries
library(parsnip)

# Create model and fit
earth_fit <- mars(mode = "regression") %>%
  set_engine("earth") %>%
  fit(Volume ~ ., data = trees)

out <- butcher(earth_fit, verbose = TRUE)
#> ✖ The butchered object is 2.03 kB larger than the original. Do not butcher.

# Another earth model object
suppressWarnings(suppressMessages(library(earth)))
earth_mod <- earth(Volume ~ ., data = trees)
out <- butcher(earth_mod, verbose = TRUE)
#> ✖ The butchered object is 712 B larger than the original. Do not butcher.
```
