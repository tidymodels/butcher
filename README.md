
<!-- README.md is generated from README.Rmd. Please edit that file -->

# butcher <a href='https://tidymodels.github.io/butcher/'><img src='butcher.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/tidymodels/butcher.svg?branch=master)](https://travis-ci.org/tidymodels/butcher)
[![Codecov test
coverage](https://codecov.io/gh/tidymodels/butcher/branch/master/graph/badge.svg)](https://codecov.io/gh/tidymodels/butcher?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## Overview

Modeling pipelines in `R` occasionally result in fitted model objects
that take up too much memory. There are two main culprits:

1.  Heavy dependencies on formulas and closures that capture the
    enclosing environment in the modeling process; and
2.  Lack of selectivity in the construction of the model object itself.

As a result, fitted model objects carry over components that are often
redundant and not required for post-fit estimation activities. `butcher`
makes it easy to axe parts of the fitted output that are no longer
needed, without sacrificing much functionality from the original model
object.

## Installation

Install the released version from CRAN:

``` r
install.packages("butcher")
```

Or install the development version from [GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("tidymodels/butcher")
```

## Butchering

To make the most of your memory available, this package provides five S3
generics for you to remove parts of a model object:

  - `axe_call()`: To remove the call object.
  - `axe_ctrl()`: To remove controls associated with training.
  - `axe_data()`: To remove the original training data.
  - `axe_env()`: To remove environments.
  - `axe_fitted()`: To remove fitted values.

As an example, we wrap a `lm` model:

``` r
library(butcher)
our_model <- function() {
  some_junk_in_the_environment <- runif(1e6) # we didn't know about
  lm(mpg ~ ., data = mtcars) 
}
```

The `lm` that exists in our modeling pipeline is:

``` r
library(lobstr)
obj_size(our_model())
#> 8,022,440 B
```

When, in fact, it should only require:

``` r
small_lm <- lm(mpg ~ ., data = mtcars) 
obj_size(small_lm)
#> 22,224 B
```

To understand which part of our original model object is taking up the
most memory, we leverage the `weigh()` function:

``` r
big_lm <- our_model()
butcher::weigh(big_lm)
#> # A tibble: 25 x 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         8.01    
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

The problem here is in the `terms` component of our `big_lm`. Because of
how `lm` is implemented in the `stats` package, the environment (in
which our model was made) was also carried along in the fitted output.
To remove this (mostly) extraneous component, we can use `axe_env()`:

``` r
cleaned_lm <- butcher::axe_env(big_lm, verbose = TRUE)
#> ✔ Memory released: '7,999,256 B'
```

Comparing it against our `small_lm`, we’ll find:

``` r
butcher::weigh(cleaned_lm)
#> # A tibble: 25 x 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00789 
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
butcher::weigh(small_lm)
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
object class(es) as well as a new attribute named `butcher_disabled`
that lists any post-fit estimation functions that are disabled as a
result.

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
