# Axe controls.

Remove the controls from training attached to modeling objects.

## Usage

``` r
axe_ctrl(x, verbose = FALSE, ...)
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

Model object without control tuning parameters from training.

## Methods

See the following help topics for more details about individual
methods:`butcher`

- [`axe-C5.0`](https://butcher.tidymodels.org/dev/reference/axe-C5.0.md):
  `C5.0`

- [`axe-gam`](https://butcher.tidymodels.org/dev/reference/axe-gam.md):
  `gam`

- [`axe-ipred`](https://butcher.tidymodels.org/dev/reference/axe-ipred.md):
  `classbagg`, `regbagg`, `survbagg`

- [`axe-model_fit`](https://butcher.tidymodels.org/dev/reference/axe-model_fit.md):
  `model_fit`

- [`axe-randomForest`](https://butcher.tidymodels.org/dev/reference/axe-randomForest.md):
  `randomForest`

- [`axe-rpart`](https://butcher.tidymodels.org/dev/reference/axe-rpart.md):
  `rpart`

- [`axe-spark`](https://butcher.tidymodels.org/dev/reference/axe-spark.md):
  `ml_model`

- [`axe-train`](https://butcher.tidymodels.org/dev/reference/axe-train.md):
  `train`

- [`axe-train.recipe`](https://butcher.tidymodels.org/dev/reference/axe-train.recipe.md):
  `train.recipe`

`workflows`

- [`workflow-butcher`](https://workflows.tidymodels.org/reference/workflow-butcher.html):
  `workflow`
