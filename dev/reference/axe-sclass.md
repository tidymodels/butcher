# Axing a sclass object.

sclass objects are byproducts of classbagg objects.

## Usage

``` r
# S3 method for class 'sclass'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'sclass'
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

Axed sclass object.

## Examples

``` r
# Load libraries
library(ipred)
library(rpart)
library(MASS)

# Load data
data("GlaucomaM", package = "TH.data")

classbagg_fit <- bagging(Class ~ ., data = GlaucomaM, coob = TRUE)

out <- butcher(classbagg_fit$mtrees[[1]], verbose = TRUE)
#> ✔ Memory released: 5.72 MB

# Another classbagg object
wrapped_classbagg <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- bagging(Species ~ .,
                 data = iris,
                 nbagg = 10,
                 coob = TRUE)
  return(fit)
}

# Remove junk
cleaned_classbagg <- butcher(wrapped_classbagg(), verbose = TRUE)
#> ✔ Memory released: 13.87 MB
#> ✖ Disabled: `print()` and `summary()`

# Check size
lobstr::obj_size(cleaned_classbagg)
#> 184.14 kB
```
