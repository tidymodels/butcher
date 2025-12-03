# Axing a rpart.

rpart objects are created from the rpart package, which is used for
recursive partitioning for classification, regression and survival
trees.

## Usage

``` r
# S3 method for class 'rpart'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'rpart'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'rpart'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'rpart'
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

Axed rpart object.

## Examples

``` r
# An rpart object
wrapped_rpart <- function() {
  require("rpart")
  some_junk_in_environment <- runif(1e6)
  fit <- rpart(Kyphosis ~ Age + Number + Start,
               data = kyphosis,
               x = TRUE, y = TRUE)
  return(fit)
}

# Remove junk
cleaned_rpart <- axe_env(wrapped_rpart(), verbose = TRUE)
#> ✔ Memory released: 9.48 MB

# Check size
lobstr::obj_size(cleaned_rpart)
#> 53.42 kB
```
