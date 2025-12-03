# Axe data.

Remove the training data attached to modeling objects.

## Usage

``` r
axe_data(x, verbose = FALSE, ...)
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

Model object without the training data

## Methods

See the following help topics for more details about individual
methods:`butcher`

- [`axe-coxph`](https://butcher.tidymodels.org/dev/reference/axe-coxph.md):
  `coxph`

- [`axe-earth`](https://butcher.tidymodels.org/dev/reference/axe-earth.md):
  `earth`

- [`axe-gam`](https://butcher.tidymodels.org/dev/reference/axe-gam.md):
  `gam`

- [`axe-gausspr`](https://butcher.tidymodels.org/dev/reference/axe-gausspr.md):
  `gausspr`

- [`axe-glm`](https://butcher.tidymodels.org/dev/reference/axe-glm.md):
  `glm`

- [`axe-ipred`](https://butcher.tidymodels.org/dev/reference/axe-ipred.md):
  `classbagg`, `regbagg`, `survbagg`

- [`axe-kproto`](https://butcher.tidymodels.org/dev/reference/axe-kproto.md):
  `kproto`

- [`axe-ksvm`](https://butcher.tidymodels.org/dev/reference/axe-ksvm.md):
  `ksvm`

- [`axe-model_fit`](https://butcher.tidymodels.org/dev/reference/axe-model_fit.md):
  `model_fit`

- [`axe-NaiveBayes`](https://butcher.tidymodels.org/dev/reference/axe-NaiveBayes.md):
  `NaiveBayes`

- [`axe-pls`](https://butcher.tidymodels.org/dev/reference/axe-pls.md):
  `mixo_pls`, `mixo_spls`

- [`axe-rpart`](https://butcher.tidymodels.org/dev/reference/axe-rpart.md):
  `rpart`

- [`axe-spark`](https://butcher.tidymodels.org/dev/reference/axe-spark.md):
  `ml_model`

- [`axe-survreg`](https://butcher.tidymodels.org/dev/reference/axe-survreg.md):
  `survreg`

- [`axe-survreg.penal`](https://butcher.tidymodels.org/dev/reference/axe-survreg.penal.md):
  `survreg.penal`

- [`axe-train`](https://butcher.tidymodels.org/dev/reference/axe-train.md):
  `train`

- [`axe-train.recipe`](https://butcher.tidymodels.org/dev/reference/axe-train.recipe.md):
  `train.recipe`

`workflows`

- [`workflow-butcher`](https://workflows.tidymodels.org/reference/workflow-butcher.html):
  `workflow`
