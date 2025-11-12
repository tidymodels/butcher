# Axing a MASS discriminant analysis object.

lda and qda objects are created from the MASS package, leveraged to
carry out linear discriminant analysis and quadratic discriminant
analysis, respectively.

## Usage

``` r
# S3 method for class 'lda'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'qda'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'polr'
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

Axed lda or qda object.

## Examples

``` r
library(MASS)

fit_da <- function(fit_fn) {
  boop <- runif(1e6)
  fit_fn(y ~ x, data.frame(y = rep(letters[1:4], 10000), x = rnorm(40000)))
}

lda_fit <- fit_da(lda)
qda_fit <- fit_da(qda)

lda_fit_b <- butcher(lda_fit)
qda_fit_b <- butcher(qda_fit)

weigh(lda_fit)
#> # A tibble: 9 × 2
#>   object       size
#>   <chr>       <dbl>
#> 1 terms   17.5     
#> 2 call     0.00202 
#> 3 means    0.00084 
#> 4 scaling  0.000624
#> 5 prior    0.000496
#> 6 counts   0.00048 
#> 7 lev      0.000304
#> 8 svd      0.000056
#> 9 N        0.000056
weigh(lda_fit_b)
#> # A tibble: 9 × 2
#>   object      size
#>   <chr>      <dbl>
#> 1 terms   0.00326 
#> 2 call    0.00202 
#> 3 means   0.00084 
#> 4 scaling 0.000624
#> 5 prior   0.000496
#> 6 counts  0.00048 
#> 7 lev     0.000304
#> 8 svd     0.000056
#> 9 N       0.000056

weigh(qda_fit)
#> # A tibble: 9 × 2
#>   object       size
#>   <chr>       <dbl>
#> 1 terms   17.5     
#> 2 call     0.00202 
#> 3 scaling  0.00162 
#> 4 means    0.00084 
#> 5 prior    0.000496
#> 6 counts   0.00048 
#> 7 lev      0.000304
#> 8 ldet     0.00008 
#> 9 N        0.000056
weigh(qda_fit_b)
#> # A tibble: 9 × 2
#>   object      size
#>   <chr>      <dbl>
#> 1 terms   0.00326 
#> 2 call    0.00202 
#> 3 scaling 0.00162 
#> 4 means   0.00084 
#> 5 prior   0.000496
#> 6 counts  0.00048 
#> 7 lev     0.000304
#> 8 ldet    0.00008 
#> 9 N       0.000056

wrapped_polr <- function(fit_fn) {
  boop <- runif(1e6)
  fit <- fit_fn(Sat ~ Infl + Type + Cont, weights = Freq, data = housing)
  return(fit)
}
polr_fit <- wrapped_polr(polr)
polr_fit_b <- butcher(polr_fit)
weigh(polr_fit)
#> # A tibble: 26 × 2
#>    object             size
#>    <chr>             <dbl>
#>  1 terms         25.6     
#>  2 fitted.values  0.00369 
#>  3 lp             0.00177 
#>  4 call           0.0014  
#>  5 model.Sat      0.000984
#>  6 model.Type     0.000984
#>  7 model.Infl     0.00092 
#>  8 model.Cont     0.000848
#>  9 coefficients   0.000688
#> 10 niter          0.000392
#> # ℹ 16 more rows
weigh(polr_fit_b)
#> # A tibble: 26 × 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00437 
#>  2 fitted.values 0.00369 
#>  3 lp            0.00177 
#>  4 call          0.0014  
#>  5 model.Sat     0.000984
#>  6 model.Type    0.000984
#>  7 model.Infl    0.00092 
#>  8 model.Cont    0.000848
#>  9 coefficients  0.000688
#> 10 niter         0.000392
#> # ℹ 16 more rows
```
