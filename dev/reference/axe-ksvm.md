# Axing a ksvm object.

ksvm objects are created from kernlab package, which provides a means to
do classification, regression, clustering, novelty detection, quantile
regression and dimensionality reduction. Since fitted model objects from
kernlab are S4, the `butcher_ksvm` class is not appended.

## Usage

``` r
# S3 method for class 'ksvm'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'ksvm'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'ksvm'
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

Axed ksvm object.

## Examples

``` r
# Load libraries
library(parsnip)
library(kernlab)

# Load data
data(spam)

# Create model and fit
ksvm_class <- svm_poly(mode = "classification") %>%
  set_engine("kernlab") %>%
  fit(type ~ ., data = spam)
#>  Setting default kernel parameters  

out <- butcher(ksvm_class, verbose = TRUE)
#> ✖ The butchered object is 2.34 kB larger than the original. Do not butcher.
```
