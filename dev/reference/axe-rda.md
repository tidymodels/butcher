# Axing an rda.

rda objects are created from the klaR package, leveraged to carry out
regularized discriminant analysis.

## Usage

``` r
# S3 method for class 'rda'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'rda'
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

Axed rda object.

## Examples

``` r
library(klaR)

fit_mod <- function() {
  boop <- runif(1e6)
  rda(
    y ~ x,
    data = data.frame(y = rep(letters[1:4], 1e4), x = rnorm(4e4)),
    gamma = 0.05,
    lambda = 0.2
  )
}

mod_fit <- fit_mod()
mod_res <- butcher(mod_fit)

weigh(mod_fit)
#> # A tibble: 12 × 2
#>    object             size
#>    <chr>             <dbl>
#>  1 terms          9.49    
#>  2 call           0.00235 
#>  3 covariances    0.000864
#>  4 means          0.00084 
#>  5 covpooled      0.000512
#>  6 prior          0.000496
#>  7 regularization 0.000352
#>  8 classes        0.000304
#>  9 error.rate     0.00028 
#> 10 varnames       0.000112
#> 11 converged      0.000056
#> 12 iter           0.000056
weigh(mod_res)
#> # A tibble: 12 × 2
#>    object             size
#>    <chr>             <dbl>
#>  1 terms          0.00326 
#>  2 covariances    0.000864
#>  3 means          0.00084 
#>  4 covpooled      0.000512
#>  5 prior          0.000496
#>  6 regularization 0.000352
#>  7 classes        0.000304
#>  8 error.rate     0.00028 
#>  9 call           0.000112
#> 10 varnames       0.000112
#> 11 converged      0.000056
#> 12 iter           0.000056
```
