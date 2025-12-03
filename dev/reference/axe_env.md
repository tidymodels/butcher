# Axe an environment.

Remove the environment(s) attached to modeling objects as they are not
required in the downstream analysis pipeline. If found, the environment
is replaced with
[`rlang::base_env()`](https://rlang.r-lib.org/reference/search_envs.html).

## Usage

``` r
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

Model object with empty environments.

## Methods

See the following help topics for more details about individual
methods:`butcher`

- [`axe-coxph`](https://butcher.tidymodels.org/dev/reference/axe-coxph.md):
  `coxph`

- [`axe-flexsurvreg`](https://butcher.tidymodels.org/dev/reference/axe-flexsurvreg.md):
  `flexsurvreg`

- [`axe-formula`](https://butcher.tidymodels.org/dev/reference/axe-formula.md):
  `formula`

- [`axe-function`](https://butcher.tidymodels.org/dev/reference/axe-function.md):
  `function`

- [`axe-gam`](https://butcher.tidymodels.org/dev/reference/axe-gam.md):
  `gam`

- [`axe-gausspr`](https://butcher.tidymodels.org/dev/reference/axe-gausspr.md):
  `gausspr`

- [`axe-glm`](https://butcher.tidymodels.org/dev/reference/axe-glm.md):
  `glm`

- [`axe-ipred`](https://butcher.tidymodels.org/dev/reference/axe-ipred.md):
  `classbagg`, `regbagg`, `survbagg`

- [`axe-kknn`](https://butcher.tidymodels.org/dev/reference/axe-kknn.md):
  `kknn`

- [`axe-lm`](https://butcher.tidymodels.org/dev/reference/axe-lm.md):
  `lm`

- [`axe-mass`](https://butcher.tidymodels.org/dev/reference/axe-mass.md):
  `lda`, `polr`, `qda`

- [`axe-mda`](https://butcher.tidymodels.org/dev/reference/axe-mda.md):
  `fda`, `mda`

- [`axe-model_fit`](https://butcher.tidymodels.org/dev/reference/axe-model_fit.md):
  `model_fit`

- [`axe-nnet`](https://butcher.tidymodels.org/dev/reference/axe-nnet.md):
  `nnet`

- [`axe-randomForest`](https://butcher.tidymodels.org/dev/reference/axe-randomForest.md):
  `randomForest`

- [`axe-rda`](https://butcher.tidymodels.org/dev/reference/axe-rda.md):
  `rda`

- [`axe-recipe`](https://butcher.tidymodels.org/dev/reference/axe-recipe.md):
  `quosure`, `recipe`, `step`, `step_arrange`, `step_bagimpute`,
  `step_filter`, `step_geodist`, `step_impute_bag`, `step_impute_knn`,
  `step_interact`, `step_knnimpute`, `step_mutate`, `step_ratio`,
  `step_slice`

- [`axe-rpart`](https://butcher.tidymodels.org/dev/reference/axe-rpart.md):
  `rpart`

- [`axe-sclass`](https://butcher.tidymodels.org/dev/reference/axe-sclass.md):
  `sclass`

- [`axe-survreg`](https://butcher.tidymodels.org/dev/reference/axe-survreg.md):
  `survreg`

- [`axe-survreg.penal`](https://butcher.tidymodels.org/dev/reference/axe-survreg.penal.md):
  `survreg.penal`

- [`axe-terms`](https://butcher.tidymodels.org/dev/reference/axe-terms.md):
  `terms`

- [`axe-train`](https://butcher.tidymodels.org/dev/reference/axe-train.md):
  `train`

- [`axe-train.recipe`](https://butcher.tidymodels.org/dev/reference/axe-train.recipe.md):
  `train.recipe`

- [`axe-xgb.Booster`](https://butcher.tidymodels.org/dev/reference/axe-xgb.Booster.md):
  `xgb.Booster`

- [`axe-xrf`](https://butcher.tidymodels.org/dev/reference/axe-xrf.md):
  `xrf`

`workflows`

- [`workflow-butcher`](https://workflows.tidymodels.org/reference/workflow-butcher.html):
  `workflow`
