# butcher (development version)

# butcher 0.1.2

## Fixes

* Examples for `C50` objects were updated to reflect data files were now located in `modeldata`.

# butcher 0.1.1

## Fixes

* `modeldata` was added as a dependency since the data files required for testing axe methods on models objects instantiated for testing were moved into this library.
* `glmnet` was removed as a dependency since the new version depends on 3.6.0 or greater. Keeping it would constrain `butcher` to that same requirement. All `glmnet` tests are run locally. 
 
# butcher 0.1.0

* Added a `NEWS.md` file to track changes to the package.
