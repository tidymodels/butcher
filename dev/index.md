# butcher

## Overview

Modeling or machine learning in R can result in fitted model objects
that take up too much memory. There are two main culprits:

1.  Heavy usage of formulas and closures that capture the enclosing
    environment in model training
2.  Lack of selectivity in the construction of the model object itself

As a result, fitted model objects contain components that are often
redundant and not required for post-fit estimation activities. The
butcher package provides tooling to “axe” parts of the fitted output
that are no longer needed, without sacrificing prediction functionality
from the original model object.

## Installation

Install the released version from CRAN:

``` r
install.packages("butcher")
```

Or install the development version from [GitHub](https://github.com/):

``` r
# install.packages("pak")
pak::pak("tidymodels/butcher")
```

## Butchering

As an example, let’s wrap an `lm` model so it contains a lot of
unnecessary stuff:

``` r
library(butcher)
our_model <- function() {
  some_junk_in_the_environment <- runif(1e6) # we didn't know about
  lm(mpg ~ ., data = mtcars)
}
```

This object is unnecessarily large:

``` r
library(lobstr)
obj_size(our_model())
#> 8.02 MB
```

When, in fact, it should only be:

``` r
small_lm <- lm(mpg ~ ., data = mtcars)
obj_size(small_lm)
#> 22.22 kB
```

To understand which part of our original model object is taking up the
most memory, we leverage the
[`weigh()`](https://butcher.tidymodels.org/dev/reference/weigh.md)
function:

``` r
big_lm <- our_model()
weigh(big_lm)
#> # A tibble: 25 × 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         8.01    
#>  2 qr.qr         0.00666 
#>  3 residuals     0.00286 
#>  4 fitted.values 0.00286 
#>  5 effects       0.0014  
#>  6 coefficients  0.00109 
#>  7 call          0.000728
#>  8 model.mpg     0.000304
#>  9 model.cyl     0.000304
#> 10 model.disp    0.000304
#> # ℹ 15 more rows
```

The problem here is in the `terms` component of our `big_lm`. Because of
how [`lm()`](https://rdrr.io/r/stats/lm.html) is implemented in the
`stats` package, the environment in which our model was made is carried
along in the fitted output. To remove the (mostly) extraneous component,
we can use
[`butcher()`](https://butcher.tidymodels.org/dev/reference/butcher.md):

``` r
cleaned_lm <- butcher(big_lm, verbose = TRUE)
#> ✔ Memory released: 8.00 MB
#> ✖ Disabled: `print()`, `summary()`, and `fitted()`
```

Comparing it against our `small_lm`, we find:

``` r
weigh(cleaned_lm)
#> # A tibble: 25 × 2
#>    object           size
#>    <chr>           <dbl>
#>  1 terms        0.00771 
#>  2 qr.qr        0.00666 
#>  3 residuals    0.00286 
#>  4 effects      0.0014  
#>  5 coefficients 0.00109 
#>  6 model.mpg    0.000304
#>  7 model.cyl    0.000304
#>  8 model.disp   0.000304
#>  9 model.hp     0.000304
#> 10 model.drat   0.000304
#> # ℹ 15 more rows
```

And now it will take up about the same memory on disk as `small_lm`:

``` r
weigh(small_lm)
#> # A tibble: 25 × 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00763 
#>  2 qr.qr         0.00666 
#>  3 residuals     0.00286 
#>  4 fitted.values 0.00286 
#>  5 effects       0.0014  
#>  6 coefficients  0.00109 
#>  7 call          0.000728
#>  8 model.mpg     0.000304
#>  9 model.cyl     0.000304
#> 10 model.disp    0.000304
#> # ℹ 15 more rows
```

To make the most of your memory available, this package provides five S3
generics for you to remove parts of a model object:

- [`axe_call()`](https://butcher.tidymodels.org/dev/reference/axe_call.md):
  To remove the call object.
- [`axe_ctrl()`](https://butcher.tidymodels.org/dev/reference/axe_ctrl.md):
  To remove controls associated with training.
- [`axe_data()`](https://butcher.tidymodels.org/dev/reference/axe_data.md):
  To remove the original training data.
- [`axe_env()`](https://butcher.tidymodels.org/dev/reference/axe_env.md):
  To remove environments.
- [`axe_fitted()`](https://butcher.tidymodels.org/dev/reference/axe_fitted.md):
  To remove fitted values.

When you run
[`butcher()`](https://butcher.tidymodels.org/dev/reference/butcher.md),
you execute all of these axing functions at once. Any kind of axing on
the object will append a butchered class to the current model object
class(es) as well as a new attribute named `butcher_disabled` that lists
any post-fit estimation functions that are disabled as a result.

## Model Object Coverage

Check out the
[`vignette("available-axe-methods")`](https://butcher.tidymodels.org/dev/articles/available-axe-methods.md)
to see butcher’s current coverage. If you are working with a new model
object that could benefit from any kind of axing, we would love for you
to make a pull request! You can visit the
[`vignette("adding-models-to-butcher")`](https://butcher.tidymodels.org/dev/articles/adding-models-to-butcher.md)
for more guidelines, but in short, to contribute a set of axe methods:

1.  Run
    `new_model_butcher(model_class = "your_object", package_name = "your_package")`
2.  Use butcher helper functions
    [`weigh()`](https://butcher.tidymodels.org/dev/reference/weigh.md)
    and
    [`locate()`](https://butcher.tidymodels.org/dev/reference/locate.md)
    to decide what to axe
3.  Finalize edits to `R/your_object.R` and
    `tests/testthat/test-your_object.R`
4.  Make a pull request!

## Contributing

This project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

- For questions and discussions about tidymodels packages, modeling, and
  machine learning, please [post on RStudio
  Community](https://forum.posit.co/new-topic?category_id=15&tags=tidymodels,question).

- If you think you have encountered a bug, please [submit an
  issue](https://github.com/tidymodels/butcher/issues).

- Either way, learn how to create and share a
  [reprex](https://reprex.tidyverse.org/articles/articles/learn-reprex.html)
  (a minimal, reproducible example), to clearly communicate about your
  code.

- Check out further details on [contributing guidelines for tidymodels
  packages](https://www.tidymodels.org/contribute/) and [how to get
  help](https://www.tidymodels.org/help/).
