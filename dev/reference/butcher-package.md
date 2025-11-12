# Reduce the Size of Modeling Objects

Reduce the size of modeling objects after fitting. These parsed-down
versions of the original modeling object have been tested to work with
their respective `predict` functions. Future iterations of this package
should support additional analysis functions outside of just `predict`.

This package provides five S3 generics:

- [`axe_call`](https://butcher.tidymodels.org/dev/reference/axe_call.md)
  To remove the call object.

- [`axe_ctrl`](https://butcher.tidymodels.org/dev/reference/axe_ctrl.md)
  To remove controls associated with training.

- [`axe_data`](https://butcher.tidymodels.org/dev/reference/axe_data.md)
  To remove the original data.

- [`axe_env`](https://butcher.tidymodels.org/dev/reference/axe_env.md)
  To remove inherited environments.

- [`axe_fitted`](https://butcher.tidymodels.org/dev/reference/axe_fitted.md)
  To remove fitted values.

These specific attributes of the model objects are chosen as they are
often not required for downstream data analysis functions to work and
are often the heaviest components of the fitted object. By calling the
wrapper function `butcher`, all the sub-axe functions listed above are
executed on the model object, returning a butchered model object that
has an additional `butcher` class assignment. If only a specific `axe_`
function is called, the axed model object will also have the same
addition of a `butcher` class assignment.

## See also

Useful links:

- <https://butcher.tidymodels.org/>

- <https://github.com/tidymodels/butcher>

- Report bugs at <https://github.com/tidymodels/butcher/issues>

## Author

**Maintainer**: Julia Silge <julia.silge@posit.co>
([ORCID](https://orcid.org/0000-0002-3671-836X))

Authors:

- Joyce Cahoon <joyceyu48@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-7217-4702))

- Davis Vaughan <davis@posit.co>

- Max Kuhn <max@posit.co>

- Alex Hayes <alexpghayes@gmail.com>

Other contributors:

- Posit, PBC \[copyright holder, funder\]
