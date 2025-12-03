# Axe indicators within rsample objects.

Replace the splitting and resampling objects with a placeholder.

## Usage

``` r
axe_rsample_indicators(x, verbose = FALSE, ...)

# Default S3 method
axe_rsample_indicators(x, verbose = FALSE, ...)

# S3 method for class 'rsplit'
axe_rsample_indicators(x, verbose = FALSE, ...)

# S3 method for class 'three_way_split'
axe_rsample_indicators(x, verbose = FALSE, ...)

# S3 method for class 'rset'
axe_rsample_indicators(x, verbose = FALSE, ...)

# S3 method for class 'tune_results'
axe_rsample_indicators(x, verbose = FALSE, ...)

# S3 method for class 'workflow_set'
axe_rsample_indicators(x, verbose = FALSE, ...)
```

## Arguments

- x:

  An object.

- verbose:

  Print information each time an axe method is executed. Notes how much
  memory is released and what functions are disabled. Default is
  `FALSE`.

- ...:

  Any additional arguments related to axing.

## Value

An updated object without the indicators in the `rsplit` objects.

## Details

Resampling and splitting objects produced by rsample contain `rsplit`
objects. These contain the original data set as well as indicators that
specify which rows go into which data partitions. These size of these
integers might be large so we sometimes wish to remove them when saving
objects. This method saves a zero-row integer in their place.

## Methods

See the following help topics for more details about individual
methods:`butcher`

- `axe-rsample-indicators`: `default`, `rset`, `rsplit`,
  `three_way_split`, `tune_results`, `workflow_set`

## Examples

``` r
large_cars <- mtcars[rep(1:32, 50), ]
large_cars_split <- rsample::initial_split(large_cars)
butcher(large_cars_split, verbose = TRUE)
#> ✔ Memory released: 269.41 kB
#> ✖ Disabled: `analysis()`, `as.data.frame()`, `as.integer()`, `assessment()`, `complement()`, `internal_calibration_split()`, `populate()`, `reverse_splits()`, `testing()`, `tidy()`, and `training()`
#> <Training/Testing/Total>
#> <0/0/0>
```
