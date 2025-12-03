# Changelog

## butcher (development version)

- Added methods for
  [`MASS::polr`](https://rdrr.io/pkg/MASS/man/polr.html)
  ([@pbulsink](https://github.com/pbulsink),
  [\#289](https://github.com/tidymodels/butcher/issues/289)).

- Make to work with new versions of xgboost models
  ([\#294](https://github.com/tidymodels/butcher/issues/294)).

- Added butcher methods for `tabnet()`
  ([@cregouby](https://github.com/cregouby)
  [\#226](https://github.com/tidymodels/butcher/issues/226)).

- - Added methods for
    [`MASS::polr`](https://rdrr.io/pkg/MASS/man/polr.html)
    ([@pbulsink](https://github.com/pbulsink),
    [\#289](https://github.com/tidymodels/butcher/issues/289)).

## butcher 0.3.6

CRAN release: 2025-08-18

- Updated methods for
  [`kknn::kknn()`](https://rdrr.io/pkg/kknn/man/kknn.html) to no longer
  remove the call
  ([\#288](https://github.com/tidymodels/butcher/issues/288)).

## butcher 0.3.5

CRAN release: 2025-03-18

- Fixed how we check whether a component exists or not
  ([\#278](https://github.com/tidymodels/butcher/issues/278)).

- Removed methods for `nestedmodels::nested()`
  ([@ashbythorpe](https://github.com/ashbythorpe),
  [\#282](https://github.com/tidymodels/butcher/issues/282)).

## butcher 0.3.4

CRAN release: 2024-04-11

- Submit to CRAN for new HTML reference manuals.

## butcher 0.3.3

CRAN release: 2023-08-23

- Added methods for `nestedmodels::nested()`
  ([@ashbythorpe](https://github.com/ashbythorpe),
  [\#256](https://github.com/tidymodels/butcher/issues/256)).

- Updated methods for
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html) to also remove
  the `hat` and `offset` components
  ([@rdavis120](https://github.com/rdavis120),
  [\#255](https://github.com/tidymodels/butcher/issues/255)).

- Clarified the messaging for butchering results, as well as when
  butchering may not work for
  [`survival::coxph()`](https://rdrr.io/pkg/survival/man/coxph.html)
  ([\#261](https://github.com/tidymodels/butcher/issues/261)).

- Fixed a bug in butchering BART models
  ([\#263](https://github.com/tidymodels/butcher/issues/263)).

## butcher 0.3.2

CRAN release: 2023-03-08

- Added butcher methods for
  [`mixOmics::pls()`](https://rdrr.io/pkg/mixOmics/man/pls.html),
  [`mixOmics::spls()`](https://rdrr.io/pkg/mixOmics/man/spls.html), and
  [`mixOmics::plsda()`](https://rdrr.io/pkg/mixOmics/man/plsda.html)
  ([\#249](https://github.com/tidymodels/butcher/issues/249)).

- Added butcher methods for
  [`klaR::rda()`](https://rdrr.io/pkg/klaR/man/rda.html) and
  [`klaR::NaiveBayes()`](https://rdrr.io/pkg/klaR/man/NaiveBayes.html)
  ([\#246](https://github.com/tidymodels/butcher/issues/246)).

- Added butcher methods for
  [`ipred::bagging()`](https://rdrr.io/pkg/ipred/man/bagging.html)
  ([\#245](https://github.com/tidymodels/butcher/issues/245)).

- Added butcher methods for
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html) and
  [`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html)
  ([\#244](https://github.com/tidymodels/butcher/issues/244)).

- Added butcher methods for
  [`survival::coxph()`](https://rdrr.io/pkg/survival/man/coxph.html)
  ([\#243](https://github.com/tidymodels/butcher/issues/243)).

- Added butcher methods for
  [`xrf::xrf()`](https://rdrr.io/pkg/xrf/man/xrf.html)
  ([\#242](https://github.com/tidymodels/butcher/issues/242)).

- Added butcher methods for
  [`mda::fda()`](https://rdrr.io/pkg/mda/man/fda.html)
  ([\#241](https://github.com/tidymodels/butcher/issues/241)).

- Added butcher methods for
  [`dbarts::bart()`](https://rdrr.io/pkg/dbarts/man/bart.html)
  ([\#240](https://github.com/tidymodels/butcher/issues/240)).

## butcher 0.3.1

CRAN release: 2022-12-14

- Added butcher methods for
  [`ClusterR::KMeans_rcpp()`](https://mlampros.github.io/ClusterR/reference/KMeans_rcpp.html)
  ([\#236](https://github.com/tidymodels/butcher/issues/236)).

- Added butcher methods for
  [`clustMixType::kproto()`](https://rdrr.io/pkg/clustMixType/man/kproto.html)
  ([@galen-ft](https://github.com/galen-ft),
  [\#235](https://github.com/tidymodels/butcher/issues/235)).

## butcher 0.3.0

CRAN release: 2022-08-25

- Julia Silge is now the maintainer
  ([\#230](https://github.com/tidymodels/butcher/issues/230)).

- Updated printing for
  [`memory_released()`](https://butcher.tidymodels.org/dev/reference/ui.md)
  ([\#229](https://github.com/tidymodels/butcher/issues/229)).

- Added butcher methods for
  [`mgcv::gam()`](https://rdrr.io/pkg/mgcv/man/gam.html)
  ([\#228](https://github.com/tidymodels/butcher/issues/228)).

## butcher 0.2.0

CRAN release: 2022-06-14

- Added an
  [`axe_fitted()`](https://butcher.tidymodels.org/dev/reference/axe_fitted.md)
  method to butcher the `template` slot for prepped recipes
  ([@AshesITR](https://github.com/AshesITR),
  [\#207](https://github.com/tidymodels/butcher/issues/207)).

- Added butcher methods for [`glm()`](https://rdrr.io/r/stats/glm.html)
  ([\#212](https://github.com/tidymodels/butcher/issues/212)).

- Removed
  [`axe_fitted()`](https://butcher.tidymodels.org/dev/reference/axe_fitted.md)
  and
  [`axe_ctrl()`](https://butcher.tidymodels.org/dev/reference/axe_ctrl.md)
  for xgboost, because these methods caused problems for prediction
  ([\#218](https://github.com/tidymodels/butcher/issues/218)).

- Moved usethis and fs to Suggests
  ([\#222](https://github.com/tidymodels/butcher/issues/222)).

- Removed fastICA and NMF from Suggests. fastICA requires R \>= 4.0.0
  now, and NMF is often hard to install and was only used for one test
  ([\#201](https://github.com/tidymodels/butcher/issues/201)).

- Preemptively fixed a test related to a recipes change in
  [`step_hyperbolic()`](https://recipes.tidymodels.org/reference/step_hyperbolic.html)
  ([\#220](https://github.com/tidymodels/butcher/issues/220)).

- Transitioned unit tests to make use of
  [`modeldata::Sacramento`](https://modeldata.tidymodels.org/reference/Sacramento.html)
  rather than `modeldata::okc` in anticipation of `okc`’s deprecation in
  an upcoming release of modeldata
  ([@simonpcouch](https://github.com/simonpcouch),
  [\#219](https://github.com/tidymodels/butcher/issues/219)).

## butcher 0.1.5

CRAN release: 2021-06-28

- Added an
  [`axe_env()`](https://butcher.tidymodels.org/dev/reference/axe_env.md)
  method to remove the `terms` environment for recipe steps. This covers
  most recipe steps, but certain steps still need more specific methods
  ([@juliasilge](https://github.com/juliasilge),
  [\#193](https://github.com/tidymodels/butcher/issues/193)).

## butcher 0.1.4

CRAN release: 2021-03-19

- Ensure butcher is compatible with recipes 0.1.16, where a few steps
  have been renamed.

- Fixed issue with survival 3.2-10, where butcher was using frailty
  terms incorrectly
  ([\#184](https://github.com/tidymodels/butcher/issues/184)).

## butcher 0.1.3

CRAN release: 2021-03-04

### Fixes

- Fixed an issue where axing a parsnip ‘model_fit’ would return the
  underlying model object rather than the altered ‘model_fit’.

- Fixed a few test failures related to changes in parsnip
  ([\#157](https://github.com/tidymodels/butcher/issues/157)).

## butcher 0.1.2

CRAN release: 2020-01-23

### Fixes

- Examples for `C50` objects were updated to reflect data files were now
  located in `modeldata`.

## butcher 0.1.1

CRAN release: 2020-01-07

### Fixes

- `modeldata` was added as a dependency since the data files required
  for testing axe methods on models objects instantiated for testing
  were moved into this library.
- `glmnet` was removed as a dependency since the new version depends on
  3.6.0 or greater. Keeping it would constrain `butcher` to that same
  requirement. All `glmnet` tests are run locally.

## butcher 0.1.0

CRAN release: 2019-08-09

- Added a `NEWS.md` file to track changes to the package.
