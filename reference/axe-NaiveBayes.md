# Axing a NaiveBayes.

NaiveBayes objects are created from the klaR package, leveraged to fit a
Naive Bayes Classifier.

## Usage

``` r
# S3 method for class 'NaiveBayes'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'NaiveBayes'
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

Axed NaiveBayes object.

## Examples

``` r
library(klaR)
#> Loading required package: MASS

fit_mod <- function() {
  boop <- runif(1e6)
  NaiveBayes(
    y ~ x,
    data = data.frame(y = as.factor(rep(letters[1:4], 1e4)), x = rnorm(4e4))
  )
}

mod_fit <- fit_mod()
mod_res <- butcher(mod_fit)

weigh(mod_fit)
#> # A tibble: 7 × 2
#>   object        size
#>   <chr>        <dbl>
#> 1 x.x       0.320   
#> 2 apriori   0.00118 
#> 3 tables.x  0.00076 
#> 4 call      0.000448
#> 5 levels    0.000304
#> 6 varnames  0.000112
#> 7 usekernel 0.000056
weigh(mod_res)
#> # A tibble: 6 × 2
#>   object        size
#>   <chr>        <dbl>
#> 1 apriori   0.00118 
#> 2 tables.x  0.00076 
#> 3 levels    0.000304
#> 4 call      0.000112
#> 5 varnames  0.000112
#> 6 usekernel 0.000056
```
