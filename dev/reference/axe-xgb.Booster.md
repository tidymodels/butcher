# Axing a xgb.Booster.

xgb.Booster objects are created from the xgboost package, which provides
efficient and scalable implementations of gradient boosted decision
trees. Given the reliance of post processing functions on the model
object, like `xgb.Booster.complete`, on the first class listed, the
`butcher_xgb.Booster` class is not appended.

## Usage

``` r
# S3 method for class 'xgb.Booster'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'xgb.Booster'
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

Axed xgb.Booster object.

## Examples

``` r
library(xgboost)
#> 
#> Attaching package: ‘xgboost’
#> The following object is masked from ‘package:dplyr’:
#> 
#>     slice
library(parsnip)

data(agaricus.train)
bst <- xgboost(data = agaricus.train$data,
               label = agaricus.train$label,
               eta = 1,
               nthread = 2,
               nrounds = 2,
               eval_metric = "logloss",
               objective = "binary:logistic",
               verbose = 0)

out <- butcher(bst, verbose = TRUE)
#> ✔ Memory released: 31.12 kB
#> ✖ Disabled: `print()`, `summary()`, and `xgb.Booster.complete()`
#> ✖ Could not add <butchered> class

# Another xgboost model
fit <- boost_tree(mode = "classification", trees = 20) %>%
  set_engine("xgboost", eval_metric = "mlogloss") %>%
  fit(Species ~ ., data = iris)

out <- butcher(fit, verbose = TRUE)
#> ✖ The butchered object is 1.14 kB larger than the original. Do not butcher.
```
