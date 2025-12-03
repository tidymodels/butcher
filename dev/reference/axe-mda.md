# Axing a mda.

mda and fda objects are created from the mda package, leveraged to carry
out mixture discriminant analysis and flexible discriminat analysis,
respectively.

## Usage

``` r
# S3 method for class 'mda'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'fda'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'mda'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'fda'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'mda'
axe_fitted(x, verbose = FALSE, ...)

# S3 method for class 'fda'
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

Axed mda object.

## Examples

``` r
library(mda)
#> Loading required package: class
#> Loaded mda 0.5-5
#> 
#> Attaching package: ‘mda’
#> The following object is masked from ‘package:parsnip’:
#> 
#>     mars

mtcars$cyl <- as.factor(mtcars$cyl)

fit <- mda(cyl ~ ., data = mtcars)
out <- butcher(fit, verbose = TRUE)
#> ✔ Memory released: 1.49 MB
#> ✖ Disabled: `print()`, `summary()`, and `update()`

fit2 <- fda(cyl ~ ., data = mtcars)
out2 <- butcher(fit2, verbose = TRUE)
#> ✔ Memory released: 1.50 MB
#> ✖ Disabled: `print()`, `summary()`, and `update()`

# Another mda object
data(glass)
wrapped_mda <- function(fit_fn) {
  some_junk_in_environment <- runif(1e6)
  fit <- fit_fn(Type ~ ., data = glass)
  return(fit)
}

lobstr::obj_size(wrapped_mda(mda))
#> 8.16 MB
lobstr::obj_size(butcher(wrapped_mda(mda)))
#> 29.60 kB

lobstr::obj_size(wrapped_mda(fda))
#> 8.10 MB
lobstr::obj_size(butcher(wrapped_mda(fda)))
#> 15.05 kB
```
