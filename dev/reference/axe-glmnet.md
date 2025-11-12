# Axing a glmnet.

glmnet objects are created from the glmnet package, leveraged to fit
generalized linear models via penalized maximum likelihood.

## Usage

``` r
# S3 method for class 'glmnet'
axe_call(x, verbose = FALSE, ...)
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

Axed glmnet object.

## Examples

``` r
library(parsnip)

# Wrap a parsnip glmnet model
wrapped_parsnip_glmnet <- function() {
  some_junk_in_environment <- runif(1e6)
  model <- logistic_reg(penalty = 10, mixture = 0.1) %>%
    set_engine("glmnet") %>%
    fit(as.factor(vs) ~ ., data = mtcars)
  return(model$fit)
}

out <- butcher(wrapped_parsnip_glmnet(), verbose = TRUE)
#> ✔ Memory released: 1.08 kB
#> ✖ Disabled: `print()` and `summary()`
```
