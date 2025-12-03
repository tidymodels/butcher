# Axing an model_fit.

model_fit objects are created from the `parsnip` package.

## Usage

``` r
# S3 method for class 'model_fit'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'model_fit'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'model_fit'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'model_fit'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'model_fit'
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

Axed model_fit object.

## Examples

``` r
library(parsnip)
library(rpart)

# Create model and fit
lm_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(mpg ~ ., data = mtcars)

out <- butcher(lm_fit, verbose = TRUE)
#> ✔ Memory released: 1.48 MB

# Another parsnip model
gam_fit <- gen_additive_mod() %>%
  set_mode("regression") %>%
  fit(mpg ~ s(disp) + wt + gear, data = mtcars)

out <- butcher(gam_fit, verbose = TRUE)
#> ✔ Memory released: 1.53 MB
```
