# Axing an lm.

lm objects are created from the base stats package.

## Usage

``` r
# S3 method for class 'lm'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'lm'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'lm'
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

Axed lm object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)

# Load data
split <- initial_split(mtcars, prop = 9/10)
car_train <- training(split)

# Create model and fit
lm_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = car_train)

out <- butcher(lm_fit, verbose = TRUE)
#> ✔ Memory released: 1.49 MB

# Another lm object
wrapped_lm <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- lm(mpg ~ ., data = mtcars)
  return(fit)
}

# Remove junk
cleaned_lm <- axe_env(wrapped_lm(), verbose = TRUE)
#> ✔ Memory released: 9.53 MB

# Check size
lobstr::obj_size(cleaned_lm)
#> 23.18 kB

# Compare environment in terms component
lobstr::obj_size(attr(wrapped_lm()$terms, ".Environment"))
#> 8.02 MB
lobstr::obj_size(attr(cleaned_lm$terms, ".Environment"))
#> 0 B
```
