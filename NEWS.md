# butcher (development version)

* Added butcher methods for `tabnet()` (@cregouby #226).

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
