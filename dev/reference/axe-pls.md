# Axing mixOmics models

`mixo_pls` (via
[`pls()`](https://parsnip.tidymodels.org/reference/pls.html)),
`mixo_spls` (via `spls()`), and `mixo_plsda` (via
[`plsda()`](https://rdrr.io/pkg/caret/man/plsda.html)) objects are
created with the mixOmics package, leveraged to fit partial least
squares models.

## Usage

``` r
# S3 method for class 'mixo_pls'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'mixo_spls'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'mixo_pls'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'mixo_spls'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'mixo_pls'
axe_fitted(x, verbose = FALSE, ...)

# S3 method for class 'mixo_spls'
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

Axed `mixo_pls`, `mixo_spls`, or `mixo_plsda` object.

## Details

The mixOmics package is not available on CRAN, but can be installed from
the Bioconductor repository via `remotes::install_bioc("mixOmics")`.

## Examples

``` r
library(butcher)
do.call(library, list(package = "mixOmics"))
#> 
#> Loaded mixOmics 6.34.0
#> Thank you for using mixOmics!
#> Tutorials: http://mixomics.org
#> Bookdown vignette: https://mixomicsteam.github.io/Bookdown
#> Questions, issues: Follow the prompts at http://mixomics.org/contact-us
#> Cite us:  citation('mixOmics')
#> 
#> Attaching package: ‘mixOmics’
#> The following objects are masked from ‘package:caret’:
#> 
#>     nearZeroVar, plsda, splsda
#> The following objects are masked from ‘package:parsnip’:
#> 
#>     pls, tune

# pls ------------------------------------------------------------------
fit_mod <- function() {
  boop <- runif(1e6)
  pls(matrix(rnorm(2e4), ncol = 2), rnorm(1e4), mode = "classic")
}

mod_fit <- fit_mod()
mod_res <- butcher(mod_fit)

weigh(mod_fit)
#> # A tibble: 24 × 2
#>    object             size
#>    <chr>             <dbl>
#>  1 X              0.842   
#>  2 Y              0.762   
#>  3 names.sample   0.681   
#>  4 variates.X     0.201   
#>  5 variates.Y     0.201   
#>  6 input.X        0.161   
#>  7 call           0.00129 
#>  8 loadings.X     0.000776
#>  9 loadings.Y     0.000696
#> 10 loadings.star1 0.0006  
#> # ℹ 14 more rows
weigh(mod_res)
#> # A tibble: 24 × 2
#>    object              size
#>    <chr>              <dbl>
#>  1 X               0.842   
#>  2 Y               0.762   
#>  3 variates.X      0.201   
#>  4 variates.Y      0.201   
#>  5 loadings.X      0.000776
#>  6 loadings.Y      0.000696
#>  7 loadings.star1  0.0006  
#>  8 mat.c           0.0006  
#>  9 loadings.star2  0.00052 
#> 10 prop_expl_var.X 0.000352
#> # ℹ 14 more rows

new_data <- matrix(1:2, ncol = 2)
colnames(new_data) <- c("X1", "X2")
predict(mod_fit, new_data)
#> 
#> Call:
#>  predict.mixo_pls(object = mod_fit, newdata = new_data) 
#> 
#>  Main numerical outputs: 
#>  -------------------- 
#>  Prediction values of the test samples for each component: see object$predict 
#>  variates of the test samples: see object$variates 
predict(mod_res, new_data)
#> 
#> Call:
#>  predict.mixo_pls(object = mod_res, newdata = new_data) 
#> 
#>  Main numerical outputs: 
#>  -------------------- 
#>  Prediction values of the test samples for each component: see object$predict 
#>  variates of the test samples: see object$variates 
```
