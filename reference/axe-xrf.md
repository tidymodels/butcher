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
#> ✔ Memory released: 9.58 MB

weigh(heavy_m)
#> # A tibble: 32 × 2
#>    object                        size
#>    <chr>                        <dbl>
#>  1 glm.formula               9.63    
#>  2 base_formula              9.63    
#>  3 rule_augmented_formula    9.63    
#>  4 glm.model.glmnet.fit.beta 0.0185  
#>  5 glm.model.glmnet.fit.call 0.0110  
#>  6 glm.model.glmnet.fit.a0   0.00654 
#>  7 glm.model.nzero           0.00619 
#>  8 glm.model.call            0.00114 
#>  9 glm.model.lambda          0.000752
#> 10 glm.model.cvm             0.000752
#> # ℹ 22 more rows
weigh(m)
#> # A tibble: 32 × 2
#>    object                        size
#>    <chr>                        <dbl>
#>  1 glm.model.glmnet.fit.beta 0.0185  
#>  2 glm.formula               0.0103  
#>  3 glm.model.glmnet.fit.a0   0.00654 
#>  4 glm.model.nzero           0.00619 
#>  5 rule_augmented_formula    0.00490 
#>  6 base_formula              0.00283 
#>  7 glm.model.lambda          0.000752
#>  8 glm.model.cvm             0.000752
#>  9 glm.model.cvsd            0.000752
#> 10 glm.model.cvup            0.000752
#> # ℹ 22 more rows
```
