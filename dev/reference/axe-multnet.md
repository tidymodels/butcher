# Axing an multnet.

multnet objects are created from carrying out multinomial regression in
the glmnet package.

## Usage

``` r
# S3 method for class 'multnet'
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

Axed multnet object.

## Examples

``` r
# Load libraries
library(parsnip)

# Load data
set.seed(1234)
predictrs <- matrix(rnorm(100*20), ncol = 20)
colnames(predictrs) <- paste0("a", seq_len(ncol(predictrs)))
response <- as.factor(sample(1:4, 100, replace = TRUE))

# Create model and fit
multnet_fit <- multinom_reg(penalty = 0.1) %>%
  set_engine("glmnet") %>%
  fit_xy(x = predictrs, y = response)

out <- butcher(multnet_fit, verbose = TRUE)
#> ✔ Memory released: 128 B
```
