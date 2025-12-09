# Axe a call.

Replace the call object attached to modeling objects with a placeholder.

## Usage

``` r
axe_call(x, verbose = FALSE, ...)
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

Model object without call attribute.

## Methods

See the following help topics for more details about individual
methods:`butcher`

- [`axe-bart`](https://butcher.tidymodels.org/reference/axe-bart.md):
  `bart`

- [`axe-C5.0`](https://butcher.tidymodels.org/reference/axe-C5.0.md):
  `C5.0`

- [`axe-earth`](https://butcher.tidymodels.org/reference/axe-earth.md):
  `earth`

- [`axe-elnet`](https://butcher.tidymodels.org/reference/axe-elnet.md):
  `elnet`

- [`axe-flexsurvreg`](https://butcher.tidymodels.org/reference/axe-flexsurvreg.md):
  `flexsurvreg`

- [`axe-gam`](https://butcher.tidymodels.org/reference/axe-gam.md):
  `gam`

- [`axe-gausspr`](https://butcher.tidymodels.org/reference/axe-gausspr.md):
  `gausspr`

- [`axe-glm`](https://butcher.tidymodels.org/reference/axe-glm.md):
  `glm`

- [`axe-glmnet`](https://butcher.tidymodels.org/reference/axe-glmnet.md):
  `glmnet`

- [`axe-ipred`](https://butcher.tidymodels.org/reference/axe-ipred.md):
  `classbagg`, `regbagg`, `survbagg`

- [`axe-KMeansCluster`](https://butcher.tidymodels.org/reference/axe-KMeansCluster.md):
  `KMeansCluster`

- [`axe-ksvm`](https://butcher.tidymodels.org/reference/axe-ksvm.md):
  `ksvm`

- [`axe-lm`](https://butcher.tidymodels.org/reference/axe-lm.md): `lm`

- [`axe-mda`](https://butcher.tidymodels.org/reference/axe-mda.md):
  `fda`, `mda`

- [`axe-model_fit`](https://butcher.tidymodels.org/reference/axe-model_fit.md):
  `model_fit`

- [`axe-multnet`](https://butcher.tidymodels.org/reference/axe-multnet.md):
  `multnet`

- [`axe-NaiveBayes`](https://butcher.tidymodels.org/reference/axe-NaiveBayes.md):
  `NaiveBayes`

- [`axe-nnet`](https://butcher.tidymodels.org/reference/axe-nnet.md):
  `nnet`

- [`axe-pls`](https://butcher.tidymodels.org/reference/axe-pls.md):
  `mixo_pls`, `mixo_spls`

- [`axe-randomForest`](https://butcher.tidymodels.org/reference/axe-randomForest.md):
  `randomForest`

- [`axe-ranger`](https://butcher.tidymodels.org/reference/axe-ranger.md):
  `ranger`

- [`axe-rda`](https://butcher.tidymodels.org/reference/axe-rda.md):
  `rda`

- [`axe-rpart`](https://butcher.tidymodels.org/reference/axe-rpart.md):
  `rpart`

- [`axe-sclass`](https://butcher.tidymodels.org/reference/axe-sclass.md):
  `sclass`

- [`axe-spark`](https://butcher.tidymodels.org/reference/axe-spark.md):
  `ml_model`

- [`axe-survreg`](https://butcher.tidymodels.org/reference/axe-survreg.md):
  `survreg`

- [`axe-survreg.penal`](https://butcher.tidymodels.org/reference/axe-survreg.penal.md):
  `survreg.penal`

- [`axe-train`](https://butcher.tidymodels.org/reference/axe-train.md):
  `train`

- [`axe-train.recipe`](https://butcher.tidymodels.org/reference/axe-train.recipe.md):
  `train.recipe`

- [`axe-xgb.Booster`](https://butcher.tidymodels.org/reference/axe-xgb.Booster.md):
  `xgb.Booster`

- [`axe-xrf`](https://butcher.tidymodels.org/reference/axe-xrf.md):
  `xrf`

`workflows`

- [`workflow-butcher`](https://workflows.tidymodels.org/reference/workflow-butcher.html):
  `workflow`
