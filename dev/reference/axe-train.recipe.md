# Axing a train.recipe object.

train.recipe objects are slightly different from train objects created
from the `caret` package in that it also includes instructions from a
`recipe` for data pre-processing. Axing functions specific to
train.recipe are thus included as additional steps are required to
remove parts of train.recipe objects.

## Usage

``` r
# S3 method for class 'train.recipe'
axe_call(x, ...)

# S3 method for class 'train.recipe'
axe_ctrl(x, ...)

# S3 method for class 'train.recipe'
axe_data(x, ...)

# S3 method for class 'train.recipe'
axe_env(x, ...)

# S3 method for class 'train.recipe'
axe_fitted(x, ...)
```

## Arguments

- x:

  A model object.

- ...:

  Any additional arguments related to axing.

## Value

Axed train.recipe object.

## Examples

``` r
library(recipes)
library(caret)
data(biomass, package = "modeldata")

data(biomass)
recipe <- biomass %>%
  recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  step_spatialsign(all_predictors())

train.recipe_fit <- train(recipe, biomass,
                          method = "svmRadial",
                          metric = "RMSE")

out <- butcher(train.recipe_fit, verbose = TRUE)
#> ✔ Memory released: 1.66 MB
```
