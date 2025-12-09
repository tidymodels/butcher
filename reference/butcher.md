# Butcher an object.

Reduce the size of a model object so that it takes up less memory on
disk. Currently, the model object is stripped down to the point that
only the minimal components necessary for the `predict` function to work
remain. Future adjustments to this function will be needed to avoid
removal of model fit components to ensure it works with other downstream
functions.

## Usage

``` r
butcher(x, verbose = FALSE, ...)
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

Axed model object with new butcher subclass assignment.
