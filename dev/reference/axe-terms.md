# Axing for terms inputs.

Generics related to axing objects of the term class.

## Usage

``` r
# S3 method for class 'terms'
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

Axed terms object.

## Examples

``` r
# Using lm
wrapped_lm <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- lm(mpg ~ ., data = mtcars)
  return(fit)
}

# Remove junk
cleaned_lm <- axe_env(wrapped_lm(), verbose = TRUE)
#> ✔ Memory released: 9.48 MB

# Check size
lobstr::obj_size(cleaned_lm)
#> 23.18 kB

# Compare environment in terms component
lobstr::obj_size(attr(wrapped_lm()$terms, ".Environment"))
#> 8.02 MB
lobstr::obj_size(attr(cleaned_lm$terms, ".Environment"))
#> 0 B

# Using rpart
library(rpart)

wrapped_rpart <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- rpart(Kyphosis ~ Age + Number + Start,
               data = kyphosis,
               x = TRUE,
               y = TRUE)
  return(fit)
}

lobstr::obj_size(wrapped_rpart())
#> 8.05 MB
lobstr::obj_size(axe_env(wrapped_rpart()))
#> 53.42 kB
```
