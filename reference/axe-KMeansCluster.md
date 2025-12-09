# Axing a KMeansCluster.

Axing a KMeansCluster.

## Usage

``` r
# S3 method for class 'KMeansCluster'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'KMeansCluster'
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

Axed KMeansCluster object.

## Examples

``` r
library(ClusterR)
data(dietary_survey_IBS)
dat <- scale(dietary_survey_IBS[, -ncol(dietary_survey_IBS)])
km <- KMeans_rcpp(dat, clusters = 2, num_init = 5)
out <- butcher(km, verbose = TRUE)
#> ✔ Memory released: 3.31 kB
#> ✖ Disabled: `print()` and `summary()`
```
