# butcher 0.3.4

* Submit to CRAN for new HTML reference manuals.

# butcher 0.3.3

* Added methods for `nestedmodels::nested()` (@ashbythorpe, #256).

* Updated methods for `mgcv::gam()` to also remove the `hat` and `offset` 
  components (@rdavis120, #255).
  
* Clarified the messaging for butchering results, as well as when butchering 
  may not work for `survival::coxph()` (#261).

* Fixed a bug in butchering BART models (#263).

# butcher 0.3.2

* Added butcher methods for `mixOmics::pls()`, `mixOmics::spls()`, 
  and `mixOmics::plsda()` (#249).

* Added butcher methods for `klaR::rda()` and `klaR::NaiveBayes()` (#246).

* Added butcher methods for `ipred::bagging()` (#245).

* Added butcher methods for `MASS::lda()` and `MASS::qda()` (#244).

* Added butcher methods for `survival::coxph()` (#243).

* Added butcher methods for `xrf::xrf()` (#242).

* Added butcher methods for `mda::fda()` (#241).

* Added butcher methods for `dbarts::bart()` (#240).

# butcher 0.3.1

* Added butcher methods for `ClusterR::KMeans_rcpp()` (#236).

* Added butcher methods for `clustMixType::kproto()` (@galen-ft, #235).

# butcher 0.3.0

* Julia Silge is now the maintainer (#230).

* Updated printing for `memory_released()` (#229).

* Added butcher methods for `mgcv::gam()` (#228).

# butcher 0.2.0

* Added an `axe_fitted()` method to butcher the `template` slot for prepped 
  recipes (@AshesITR, #207).

* Added butcher methods for `glm()` (#212).

* Removed `axe_fitted()` and `axe_ctrl()` for xgboost, because these methods
  caused problems for prediction (#218).

* Moved usethis and fs to Suggests (#222).

* Removed fastICA and NMF from Suggests. fastICA requires R >= 4.0.0 now, and
  NMF is often hard to install and was only used for one test (#201).

* Preemptively fixed a test related to a recipes change in `step_hyperbolic()` 
  (#220).
  
* Transitioned unit tests to make use of `modeldata::Sacramento` rather than
  `modeldata::okc` in anticipation of `okc`'s deprecation in an upcoming
  release of modeldata (@simonpcouch, #219).

# butcher 0.1.5

* Added an `axe_env()` method to remove the `terms` environment for recipe
  steps. This covers most recipe steps, but certain steps still need more
  specific methods (@juliasilge, #193).

# butcher 0.1.4

* Ensure butcher is compatible with recipes 0.1.16, where a few steps have been
  renamed.
  
* Fixed issue with survival 3.2-10, where butcher was using frailty terms
  incorrectly (#184).

# butcher 0.1.3

## Fixes

* Fixed an issue where axing a parsnip 'model_fit' would return the underlying
  model object rather than the altered 'model_fit'.

* Fixed a few test failures related to changes in parsnip (#157).

# butcher 0.1.2

## Fixes

* Examples for `C50` objects were updated to reflect data files were now located in `modeldata`.

# butcher 0.1.1

## Fixes

* `modeldata` was added as a dependency since the data files required for testing axe methods on models objects instantiated for testing were moved into this library.
* `glmnet` was removed as a dependency since the new version depends on 3.6.0 or greater. Keeping it would constrain `butcher` to that same requirement. All `glmnet` tests are run locally. 
 
# butcher 0.1.0

* Added a `NEWS.md` file to track changes to the package.
