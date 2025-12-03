# Axing a coxph.

Axing a coxph.

## Usage

``` r
# S3 method for class 'coxph'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'coxph'
axe_data(x, verbose = FALSE, ...)
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

Axed coxph object.

## Details

The [`survival::coxph()`](https://rdrr.io/pkg/survival/man/coxph.html)
model is unique in how it uses environments in its components, and
butchering such an object can behave in surprising ways in any
environment other than the [global
environment](https://adv-r.hadley.nz/environments.html#important-environments)
(such as when wrapped in a function). We do not recommend that you use
[`butcher()`](https://butcher.tidymodels.org/dev/reference/butcher.md)
with a `coxph` object anywhere other than the global environment.

Do this:

    my_coxph_func <- function(df) {
        coxph(Surv(time, status) ~ x + strata(covar), df)
    }
    ## in global environment only:
    butcher(my_coxph_func(df))

Do *not* do this:

    my_coxph_func <- function(df) {
        res <- coxph(Surv(time, status) ~ x + strata(covar), df)
        ## no:
        butcher(res)
    }

    ## will not work correctly:
    my_coxph_func(df)

## Examples

``` r
library(survival)

example_data <-
  tibble::tibble(
    time = rpois(1000, 2) + 1,
    status = rbinom(1000, 1, .5),
    x = rpois(1000, .5),
    covar = rbinom(1000, 1, .5)
  )

example_data
#> # A tibble: 1,000 × 4
#>     time status     x covar
#>    <dbl>  <int> <int> <int>
#>  1     4      1     1     0
#>  2     3      1     0     0
#>  3     3      1     1     0
#>  4     4      0     1     0
#>  5     3      0     2     1
#>  6     3      1     1     0
#>  7     3      1     1     1
#>  8     2      0     0     0
#>  9     3      1     1     1
#> 10     2      0     0     1
#> # ℹ 990 more rows

make_big_model <- function() {
  boop <- runif(1e6)
  coxph(Surv(time, status) ~ x + strata(covar), example_data)
}

res <- make_big_model()

weigh(res)
#> # A tibble: 20 × 2
#>    object                    size
#>    <chr>                    <dbl>
#>  1 terms                 9.72    
#>  2 formula               9.72    
#>  3 y                     0.0177  
#>  4 residuals             0.00948 
#>  5 linear.predictors     0.00805 
#>  6 call                  0.00146 
#>  7 concordance           0.000752
#>  8 coefficients          0.00028 
#>  9 means                 0.00028 
#> 10 wald.test             0.00028 
#> 11 var                   0.000224
#> 12 xlevels.strata(covar) 0.000176
#> 13 method                0.000112
#> 14 loglik                0.000064
#> 15 score                 0.000056
#> 16 iter                  0.000056
#> 17 n                     0.000056
#> 18 nevent                0.000056
#> 19 assign.x              0.000056
#> 20 timefix               0.000056
weigh(butcher(res))
#> # A tibble: 20 × 2
#>    object                    size
#>    <chr>                    <dbl>
#>  1 terms                 9.72    
#>  2 residuals             0.00948 
#>  3 linear.predictors     0.00805 
#>  4 formula               0.00149 
#>  5 call                  0.00146 
#>  6 concordance           0.000752
#>  7 coefficients          0.00028 
#>  8 means                 0.00028 
#>  9 wald.test             0.00028 
#> 10 var                   0.000224
#> 11 xlevels.strata(covar) 0.000176
#> 12 method                0.000112
#> 13 loglik                0.000064
#> 14 score                 0.000056
#> 15 iter                  0.000056
#> 16 n                     0.000056
#> 17 nevent                0.000056
#> 18 assign.x              0.000056
#> 19 timefix               0.000056
#> 20 y                     0.000048
```
