# Axing a bart model.

Axing a bart model.

## Usage

``` r
# S3 method for class 'bart'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'bart'
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

Axed bart object.

## Examples

``` r
library(dbarts)
#> 
#> Attaching package: ‘dbarts’
#> The following object is masked from ‘package:parsnip’:
#> 
#>     bart
x <- dbarts::bart(mtcars[,2:5], mtcars[,1], verbose = FALSE, keeptrees = TRUE)
res <- butcher(x, verbose = TRUE)
#> ✔ Memory released: 272.12 kB
#> ✖ Disabled: `print()` and `summary()`
```
