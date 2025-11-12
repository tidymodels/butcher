# Axing a glm.

glm objects are created from the base stats package.

## Usage

``` r
# S3 method for class 'glm'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'glm'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'glm'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'glm'
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

Axed glm object.

## Examples

``` r
cars_glm <- glm(mpg ~ ., data = mtcars)
cleaned_glm <- butcher(cars_glm, verbose = TRUE)
#> ✖ The butchered object is 4.85 kB larger than the original. Do not butcher.
```
