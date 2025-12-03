# Axing a xrf.

Axing a xrf.

## Usage

``` r
# S3 method for class 'xrf'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'xrf'
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

Axed xrf object.

## Examples

``` r
library(xrf)

xrf_big <- function() {
  boop <- runif(1e6)
  xrf(
    mpg ~ .,
    mtcars,
    xgb_control = list(nrounds = 2, max_depth = 2),
    family = 'gaussian'
  )
}

heavy_m <- xrf_big()

m <- butcher(heavy_m, verbose = TRUE)
#> ✔ Memory released: 9.53 MB

weigh(heavy_m)
#> # A tibble: 43 × 2
#>    object                             size
#>    <chr>                             <dbl>
#>  1 glm.formula                     9.59   
#>  2 base_formula                    9.59   
#>  3 rule_augmented_formula          9.59   
#>  4 xgb.callbacks.cb.evaluation.log 0.0351 
#>  5 glm.model.glmnet.fit.beta       0.0177 
#>  6 glm.model.glmnet.fit.call       0.0107 
#>  7 glm.model.glmnet.fit.a0         0.00654
#>  8 glm.model.nzero                 0.00619
#>  9 xgb.raw                         0.00578
#> 10 xgb.call                        0.00168
#> # ℹ 33 more rows
weigh(m)
#> # A tibble: 43 × 2
#>    object                              size
#>    <chr>                              <dbl>
#>  1 glm.model.glmnet.fit.beta       0.0177  
#>  2 glm.formula                     0.00879 
#>  3 glm.model.glmnet.fit.a0         0.00654 
#>  4 glm.model.nzero                 0.00619 
#>  5 xgb.raw                         0.00578 
#>  6 xgb.callbacks.cb.evaluation.log 0.00510 
#>  7 rule_augmented_formula          0.00423 
#>  8 base_formula                    0.00283 
#>  9 xgb.feature_names               0.0008  
#> 10 glm.model.lambda                0.000752
#> # ℹ 33 more rows
```
