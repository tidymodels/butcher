# Axing a spark object.

spark objects are created from the sparklyr package, a R interface for
Apache Spark. The axe methods available for spark objects are designed
such that interoperability is maintained. In other words, for a
multilingual machine learning team, butchered spark objects instantiated
from sparklyr can still be serialized to disk, work in Python, be
deployed on Scala, etc. It is also worth noting here that spark objects
created from sparklyr have a lot of metadata attached to it, including
but not limited to the formula, dataset, model, index labels, etc. The
axe functions provided are for parsing down the model object both prior
saving to disk, or loading from disk. Traditional R save functions are
not available for these objects, so functionality is provided in
[`sparklyr::ml_save`](https://rdrr.io/pkg/sparklyr/man/ml-persistence.html).
This function gives the user the option to keep either the
`pipeline_model` or the `pipeline`, so both of these objects are
retained from butchering, yet removal of one or the other might be
conducive to freeing up memory on disk.

## Usage

``` r
# S3 method for class 'ml_model'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'ml_model'
axe_ctrl(x, verbose = FALSE, ...)

# S3 method for class 'ml_model'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'ml_model'
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

Axed spark object.

## Examples

``` r
if (FALSE) {
library(sparklyr)

sc <- spark_connect(master = "local")

iris_tbls <- sdf_copy_to(sc, iris, overwrite = TRUE) %>%
  sdf_random_split(train = 2/3, validation = 2/3, seed = 2018)

train <- iris_tbls$train
spark_fit <- ml_logistic_regression(train, Species ~ .)

out <- butcher(spark_fit, verbose = TRUE)

spark_disconnect(sc)
}
```
