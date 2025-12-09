# Axing a kproto.

Axing a kproto.

## Usage

``` r
# S3 method for class 'kproto'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'kproto'
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

Axed kproto object.

## Examples

``` r
library(clustMixType)

kproto_fit <- kproto(
  ToothGrowth,
  k = 2,
  lambda = lambdaest(ToothGrowth),
  verbose = FALSE
)
#> Numeric variances:
#>        len       dose 
#> 58.5120226  0.3954802 
#> Average numeric variance: 29.45375 
#> 
#> Heuristic for categorical variables: (method = 1) 
#> supp 
#>  0.5 
#> Average categorical variation: 0.5 
#> 
#> Estimated lambda: 58.9075 
#> 

out <- butcher(kproto_fit, verbose = TRUE)
#> ✔ Memory released: 3.42 kB
#> ✖ Disabled: `validation_kproto()`, `summary()`, and `clprofiles()`
```
