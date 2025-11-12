# Axing a C5.0.

C5.0 objects are created from the `C50` package, which provides an
interface to the C5.0 classification model. The models that can be
generated include basic tree-based models as well as rule-based models.

## Usage

``` r
# S3 method for class 'C5.0'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'C5.0'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'C5.0'
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

Axed C5.0 object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)
library(rpart)

# Load data
set.seed(1234)
split <- initial_split(kyphosis, prop = 9/10)
spine_train <- training(split)

# Create model and fit
c5_fit <- decision_tree(mode = "classification") %>%
  set_engine("C5.0") %>%
  fit(Kyphosis ~ ., data = spine_train)

out <- butcher(c5_fit, verbose = TRUE)
#> ✖ The butchered object is 1.43 kB larger than the original. Do not butcher.

# Try another model from parsnip
c5_fit2 <- boost_tree(mode = "classification", trees = 100) %>%
  set_engine("C5.0") %>%
  fit(Kyphosis ~ ., data = spine_train)
out <- butcher(c5_fit2, verbose = TRUE)
#> ✖ The butchered object is 952 B larger than the original. Do not butcher.

# Create model object from original library
library(C50)
library(modeldata)
#> 
#> Attaching package: ‘modeldata’
#> The following object is masked from ‘package:datasets’:
#> 
#>     penguins
data(mlc_churn)
c5_fit3 <- C5.0(x = mlc_churn[, -20], y = mlc_churn$churn)
out <- butcher(c5_fit3, verbose = TRUE)
#> ✔ Memory released: 6.28 kB
#> ✖ Disabled: `print()`, `summary()`, `C5.0Control()`, and `C5imp()`
```
