# Axing formulas.

formulas might capture an environment from the modeling development
process that carries objects that will not be used for any post-
estimation activities.

## Usage

``` r
# S3 method for class 'formula'
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

Axed formula object.

## Examples

``` r
wrapped_formula <- function() {
  some_junk_in_environment <- runif(1e6)
  ex <- as.formula(paste("y ~", paste(LETTERS, collapse = "+")))
  return(ex)
}

lobstr::obj_size(wrapped_formula())
#> 8.01 MB
lobstr::obj_size(butcher(wrapped_formula()))
#> 6.42 kB

wrapped_quosure <- function() {
  some_junk_in_environment <- runif(1e6)
  out <- rlang::quo(x)
  return(out)
}
lobstr::obj_size(wrapped_quosure())
#> 8.00 MB
lobstr::obj_size(butcher(wrapped_quosure))
#> 1.74 kB
```
