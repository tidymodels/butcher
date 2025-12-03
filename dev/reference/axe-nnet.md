# Axing a nnet.

nnet objects are created from the nnet package, leveraged to fit
multilayer perceptron models.

## Usage

``` r
# S3 method for class 'nnet'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'nnet'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'nnet'
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

Axed nnet object.

## Examples

``` r
# Load libraries
library(parsnip)
library(nnet)

# Create and fit model
nnet_fit <- mlp("classification", hidden_units = 2) %>%
  set_engine("nnet") %>%
  fit(Species ~ ., data = iris)

out <- butcher(nnet_fit, verbose = TRUE)
#> ✔ Memory released: 1.49 MB

# Another nnet object
targets <- class.ind(c(rep("setosa", 50),
                       rep("versicolor", 50),
                       rep("virginica", 50)))

fit <- nnet(iris[,1:4],
            targets,
            size = 2,
            rang = 0.1,
            decay = 5e-4,
            maxit = 20)
#> # weights:  19
#> initial  value 111.305930 
#> iter  10 value 51.532163
#> iter  20 value 6.695019
#> final  value 6.695019 
#> stopped after 20 iterations

out <- butcher(fit, verbose = TRUE)
#> ✔ Memory released: 4.95 kB
#> ✖ Disabled: `fitted()`, `predict() with no new data`, and `dimnames(axed_object$fitted.values)`
```
