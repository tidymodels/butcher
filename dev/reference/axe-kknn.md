# Axing an kknn.

kknn objects are created from the kknn package, which is utilized to do
weighted k-Nearest Neighbors for classification, regression and
clustering.

## Usage

``` r
# S3 method for class 'kknn'
axe_env(x, verbose = FALSE, ...)

# S3 method for class 'kknn'
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

Axed kknn object.

## Examples

``` r
# Load libraries
library(parsnip)
library(rsample)
library(rpart)
library(kknn)
#> 
#> Attaching package: ‘kknn’
#> The following object is masked from ‘package:caret’:
#> 
#>     contr.dummy

# Load data
set.seed(1234)
split <- initial_split(kyphosis, prop = 9/10)
spine_train <- training(split)

# Create model and fit
kknn_fit <- nearest_neighbor(mode = "classification",
                             neighbors = 3,
                             weight_func = "gaussian",
                             dist_power = 2) %>%
  set_engine("kknn") %>%
  fit(Kyphosis ~ ., data = spine_train)

out <- butcher(kknn_fit, verbose = TRUE)
#> ✖ The butchered object is 1.99 kB larger than the original. Do not butcher.

# \donttest{
# Another kknn model object
m <- dim(iris)[1]
val <- sample(1:m,
              size = round(m/3),
              replace = FALSE,
              prob = rep(1/m, m))
iris.learn <- iris[-val,]
iris.valid <- iris[val,]
kknn_fit <- kknn(Species ~ .,
                 iris.learn,
                 iris.valid,
                 distance = 1,
                 kernel = "triangular")
out <- butcher(kknn_fit, verbose = TRUE)
#> ✔ Memory released: 1.52 MB
#> ✖ Disabled: `fitted()`
# }
```
