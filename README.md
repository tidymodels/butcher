
<!-- README.md is generated from README.Rmd. Please edit that file -->

# butcher

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/jyuu/butcher.svg?branch=master)](https://travis-ci.org/jyuu/butcher)
[![Codecov test
coverage](https://codecov.io/gh/jyuu/butcher/branch/master/graph/badge.svg)](https://codecov.io/gh/jyuu/butcher?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

This package helps reduce the size of modeling objects saved to disk.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jyuu/butcher")
```

## Butchering

This package provides five S3 generics for you to remove extraneous
parts of a model object:

  - `axe_call()`: To remove the call object.
  - `axe_ctrl()`: To remove controls associated with training.
  - `axe_data()`: To remove the original training data.
  - `axe_env()`: To remove environments.
  - `axe_fitted()`: To remove fitted values.

This is helpful as modeling pipelines might include junk that often gets
saved along with a fitted model object. As an example, we take a simple
`lm` approach:

``` r
library(butcher)
# basic example
in_house_model <- function() {
  some_junk_in_the_environment <- matrix(1:1e6, ncol = 10) # we didn't know about
  lm(mpg ~ ., data = mtcars) 
}
```

The `lm` that exists in our pipeline is:

``` r
library(lobstr)
obj_size(in_house_model())
#> 4,022,552 B
```

When, in fact, it’s a simple `lm` model that should only require:

``` r
small_lm <- lm(mpg ~ ., data = mtcars) 
obj_size(small_lm)
#> 22,224 B
```

We don’t want to end up saving this new `in_house_model()` on disk, when
we could have something like `small_lm` that takes up less memory. So
what the heck is going on here? We can start by examining the size of
`in_house_model()` by using `weigh()`:

``` r
big_lm <- in_house_model()
butcher::weigh(big_lm, threshold = 0, units = "MB")
#> # A tibble: 25 x 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         4.01    
#>  2 qr.qr         0.00666 
#>  3 residuals     0.00286 
#>  4 fitted.values 0.00286 
#>  5 effects       0.0014  
#>  6 coefficients  0.00109 
#>  7 call          0.000728
#>  8 model.mpg     0.000304
#>  9 model.cyl     0.000304
#> 10 model.disp    0.000304
#> # … with 15 more rows
```

The problem here is in the `terms` component of `big_lm`. Because of how
`lm` is implemented in the `stats` package, the environment in which the
`lm` model was created was carried along in the model output. To remove
this (mostly) extraneous component, we’ll leverage `axe_env()`:

``` r
cleaned_lm <- butcher::axe_env(big_lm)
#> ✔ Memory released: '3,999,528 B'
```

Comparing it against our `small_lm`, we’ll find:

``` r
butcher::weigh(cleaned_lm, threshold = 0, units = "MB")
#> # A tibble: 25 x 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00781 
#>  2 qr.qr         0.00666 
#>  3 residuals     0.00286 
#>  4 fitted.values 0.00286 
#>  5 effects       0.0014  
#>  6 coefficients  0.00109 
#>  7 call          0.000728
#>  8 model.mpg     0.000304
#>  9 model.cyl     0.000304
#> 10 model.disp    0.000304
#> # … with 15 more rows
```

…it now takes the same memory on disk as `small_lm`:

``` r
butcher::weigh(small_lm, threshold = 0, units = "MB")
#> # A tibble: 25 x 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00781 
#>  2 qr.qr         0.00666 
#>  3 residuals     0.00286 
#>  4 fitted.values 0.00286 
#>  5 effects       0.0014  
#>  6 coefficients  0.00109 
#>  7 call          0.000728
#>  8 model.mpg     0.000304
#>  9 model.cyl     0.000304
#> 10 model.disp    0.000304
#> # … with 15 more rows
```

Axing the environment is not the only functionality of `butcher`. We can
also remove `call`, `ctrl`, `data` and `fitted_values`, or simply run
`butcher()` to execute all of these axing functions at once. Any kind of
axing on the object will append a butchered class to the current model
object class(es).

## Model Object Coverage

The current axe methods have been tested on all `parsnip` model objects
as listed
[here](https://tidymodels.github.io/parsnip/articles/articles/Models.html).
If you are working with a new model object that could benefit from any
kind of axing, we would love for you to make a pull request\! You can
visit the `vignette("adding-models-to-butcher")` for more guidelines,
but in short, to contribute a set of axe methods:

1)  Run `new_model_butcher(model_class = "your_object", package_name =
    "your_package")`
2)  Use butcher helper functions `butcher::weigh()` and
    `butcher::locate()` to decide what to axe
3)  Finalize edits to `R/your_object.R` and
    `tests/testthat/test-your_object.R`
4)  Make a pull request\!

Please note that the `butcher` package is released with a [Contributor
Code of Conduct](https://usethis.r-lib.org/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
