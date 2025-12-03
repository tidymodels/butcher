# Axing a gausspr.

gausspr objects are created from kernlab package, which provides a means
to do classification, regression, clustering, novelty detection,
quantile regression and dimensionality reduction. Since fitted model
objects from kernlab are S4, the `butcher_gausspr` class is not
appended.

## Usage

``` r
# S3 method for class 'gausspr'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'gausspr'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'gausspr'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'gausspr'
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

Axed gausspr object.

## Examples

``` r
library(kernlab)
#> 
#> Attaching package: ‘kernlab’
#> The following object is masked from ‘package:ggplot2’:
#> 
#>     alpha

test <- gausspr(Species ~ ., data = iris, var = 2)
#> Using automatic sigma estimation (sigest) for RBF or laplace kernel 

out <- butcher(test, verbose = TRUE)
#> ✔ Memory released: 1.48 MB
#> ✖ Disabled: `print()`, `summary()`, and `fitted()`
#> ✖ Could not add <butchered> class

# Example with simulated regression data
x <- seq(-20, 20, 0.1)
y <- sin(x)/x + rnorm(401, sd = 0.03)
test2 <- gausspr(x, y)
#> Using automatic sigma estimation (sigest) for RBF or laplace kernel 
out <- butcher(test2, verbose = TRUE)
#> ✔ Memory released: 3.10 kB
#> ✖ Disabled: `print()`, `summary()`, and `fitted()`
#> ✖ Could not add <butchered> class
```
