# Axing a recipe object.

recipe objects are created from the recipes package, which is leveraged
for its set of data pre-processing tools. These recipes work by
sequentially defining each pre-processing step. The implementation of
each step, however, results its own class so we bundle all the axe
methods related to recipe objects in general here. Note that the
butchered class is only added to the recipe as a whole, and not to each
pre-processing step.

## Usage

``` r
# S3 method for class 'recipe'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'step'
axe_env(x, ...)

# S3 method for class 'step_arrange'
axe_env(x, ...)

# S3 method for class 'step_filter'
axe_env(x, ...)

# S3 method for class 'step_mutate'
axe_env(x, ...)

# S3 method for class 'step_slice'
axe_env(x, ...)

# S3 method for class 'step_impute_bag'
axe_env(x, ...)

# S3 method for class 'step_bagimpute'
axe_env(x, ...)

# S3 method for class 'step_impute_knn'
axe_env(x, ...)

# S3 method for class 'step_knnimpute'
axe_env(x, ...)

# S3 method for class 'step_geodist'
axe_env(x, ...)

# S3 method for class 'step_interact'
axe_env(x, ...)

# S3 method for class 'step_ratio'
axe_env(x, ...)

# S3 method for class 'quosure'
axe_env(x, ...)

# S3 method for class 'recipe'
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

Axed recipe object.

## Examples

``` r
library(recipes)
#> Loading required package: dplyr
#> 
#> Attaching package: ‘dplyr’
#> The following object is masked from ‘package:randomForest’:
#> 
#>     combine
#> The following object is masked from ‘package:MASS’:
#> 
#>     select
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
#> 
#> Attaching package: ‘recipes’
#> The following object is masked from ‘package:stats’:
#> 
#>     step
data(biomass, package = "modeldata")

biomass_tr <- biomass[biomass$dataset == "Training",]
rec <- recipe(HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
              data = biomass_tr) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  step_spatialsign(all_predictors())

out <- butcher(rec, verbose = TRUE)
#> ✔ Memory released: 1.55 MB

# Another recipe object
wrapped_recipes <- function() {
  some_junk_in_environment <- runif(1e6)
  return(
    recipe(mpg ~ cyl, data = mtcars) %>%
      step_center(all_predictors()) %>%
      step_scale(all_predictors()) %>%
      prep()
  )
}

# Remove junk in environment
cleaned1 <- axe_env(wrapped_recipes(), verbose = TRUE)
#> ✔ Memory released: 9.56 MB
# Replace prepared training data with zero-row slice
cleaned2 <- axe_fitted(wrapped_recipes(), verbose = TRUE)
#> ✔ Memory released: 296 B

# Check size
lobstr::obj_size(cleaned1)
#> 14.65 kB
lobstr::obj_size(cleaned2)
#> 8.02 MB
```
