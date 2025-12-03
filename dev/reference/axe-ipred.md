# Axing a bagged tree.

`*_bagg` objects are created from the ipred package, which is used for
bagging classification, regression and survival trees.

## Usage

``` r
# S3 method for class 'regbagg'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'classbagg'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'survbagg'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'regbagg'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'classbagg'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'survbagg'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'regbagg'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'classbagg'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'survbagg'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'regbagg'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'classbagg'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'survbagg'
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

Axed `*_bagg` object.

## Examples

``` r
library(ipred)

fit_mod <- function() {
  boop <- runif(1e6)
  bagging(y ~ x, data.frame(y = rnorm(1e4), x = rnorm(1e4)))
}

mod_fit <- fit_mod()
mod_res <- butcher(mod_fit)

weigh(mod_fit)
#> # A tibble: 705 × 2
#>    object              size
#>    <chr>              <dbl>
#>  1 mtrees.btree.call   21.9
#>  2 mtrees.btree.terms  21.9
#>  3 mtrees.btree.call   21.9
#>  4 mtrees.btree.terms  21.9
#>  5 mtrees.btree.call   21.9
#>  6 mtrees.btree.terms  21.9
#>  7 mtrees.btree.call   21.9
#>  8 mtrees.btree.terms  21.9
#>  9 mtrees.btree.call   21.9
#> 10 mtrees.btree.terms  21.9
#> # ℹ 695 more rows
weigh(mod_res)
#> # A tibble: 480 × 2
#>    object              size
#>    <chr>              <dbl>
#>  1 mtrees.btree.where 0.680
#>  2 mtrees.btree.where 0.680
#>  3 mtrees.btree.where 0.680
#>  4 mtrees.btree.where 0.680
#>  5 mtrees.btree.where 0.680
#>  6 mtrees.btree.where 0.680
#>  7 mtrees.btree.where 0.680
#>  8 mtrees.btree.where 0.680
#>  9 mtrees.btree.where 0.680
#> 10 mtrees.btree.where 0.680
#> # ℹ 470 more rows
```
