# New axe functions for a modeling object.

`new_model_butcher()` will instantiate the following to help us develop
new axe functions around removing parts of a new modeling object:

- Add modeling package to `Suggests`

- Generate and populate an axe file under `R/`

- Generate and populate an test file under `testthat/`

## Usage

``` r
new_model_butcher(
  model_class,
  package_name,
  open = interactive(),
  call = rlang::caller_env()
)
```

## Arguments

- model_class:

  A string that captures the class name of the new model object.

- package_name:

  A string that captures the package name from which the new model is
  made.

- open:

  Check if user is in interactive mode, and if so, opens the new files
  for editing.

- call:

  The execution environment of a currently running function, e.g.
  `caller_env()`. The function will be mentioned in error messages as
  the source of the error.
