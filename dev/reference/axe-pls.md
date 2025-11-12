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
if (FALSE) { # rlang::is_installed("mixOmics") && !butcher:::is_cran_check()
library(butcher)
do.call(library, list(package = "mixOmics"))

# pls ------------------------------------------------------------------
fit_mod <- function() {
  boop <- runif(1e6)
  pls(matrix(rnorm(2e4), ncol = 2), rnorm(1e4), mode = "classic")
}

mod_fit <- fit_mod()
mod_res <- butcher(mod_fit)

weigh(mod_fit)
weigh(mod_res)

new_data <- matrix(1:2, ncol = 2)
colnames(new_data) <- c("X1", "X2")
predict(mod_fit, new_data)
predict(mod_res, new_data)
}
```
