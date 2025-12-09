# butcher

``` r
library(butcher)
#> Registered S3 method overwritten by 'butcher':
#>   method                 from    
#>   as.character.dev_topic generics
library(parsnip)
```

One of the benefits of working in R is the ease with which you can
implement complex models and implement challenging data analysis
pipelines. Take, for example, the parsnip package; with the installation
of a few associated libraries and a few lines of code, you can fit
something as sophisticated as a boosted tree:

``` r
fitted_model <- boost_tree(mode = "regression") |>
  fit(mpg ~ ., data = mtcars)
```

Yet, while this code is compact, the underlying fitted result may not
be. Since parsnip works as a wrapper for many modeling packages, its
fitted model objects inherit the same properties as those that arise
from the original modeling package. A straightforward example is the
[`lm()`](https://rdrr.io/r/stats/lm.html) function from the base `stats`
package. Whether you leverage parsnip or not, you get the same result:

``` r
parsnip_lm <- linear_reg() |> 
  fit(mpg ~ ., data = mtcars) 
parsnip_lm
#> parsnip model object
#> 
#> 
#> Call:
#> stats::lm(formula = mpg ~ ., data = data)
#> 
#> Coefficients:
#> (Intercept)          cyl         disp           hp         drat  
#>    12.30337     -0.11144      0.01334     -0.02148      0.78711  
#>          wt         qsec           vs           am         gear  
#>    -3.71530      0.82104      0.31776      2.52023      0.65541  
#>        carb  
#>    -0.19942
```

Using just [`lm()`](https://rdrr.io/r/stats/lm.html):

``` r
old_lm <- lm(mpg ~ ., data = mtcars) 
old_lm
#> 
#> Call:
#> lm(formula = mpg ~ ., data = mtcars)
#> 
#> Coefficients:
#> (Intercept)          cyl         disp           hp         drat  
#>    12.30337     -0.11144      0.01334     -0.02148      0.78711  
#>          wt         qsec           vs           am         gear  
#>    -3.71530      0.82104      0.31776      2.52023      0.65541  
#>        carb  
#>    -0.19942
```

Let’s say we take this familiar `old_lm` approach in building a custom
in-house modeling pipeline. Such a pipeline might entail wrapping
[`lm()`](https://rdrr.io/r/stats/lm.html) in other function, but in
doing so, we may end up carrying around some unnecessary junk.

``` r
in_house_model <- function() {
  some_junk_in_the_environment <- runif(1e6) # we didn't know about
  lm(mpg ~ ., data = mtcars) 
}
```

The linear model fit that exists in our custom modeling pipeline is
then:

``` r
library(lobstr)
obj_size(in_house_model())
#> 8.02 MB
```

But it is functionally the same as our `old_lm`, which only takes up:

``` r
obj_size(old_lm)
#> 22.22 kB
```

Ideally, we want to avoid saving this new `in_house_model()` on disk,
when we could have something like `old_lm` that takes up less memory.
But what the heck is going on here? We can examine possible issues with
a fitted model object using the butcher package:

``` r
big_lm <- in_house_model()
weigh(big_lm, threshold = 0, units = "MB")
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

The problem here is in the `terms` component of `big_lm`. Because of how
[`lm()`](https://rdrr.io/r/stats/lm.html) is implemented in the base
`stats` package (relying on intermediate forms of the data from
`model.frame` and `model.matrix`) the **environment** in which the
linear fit was created is carried along in the model output.

We can see this with the
[`env_print()`](https://rlang.r-lib.org/reference/env_print.html)
function from the rlang package:

``` r
library(rlang)
env_print(big_lm$terms)
#> <environment: 0x55dda6a12868>
#> Parent: <environment: global>
#> Bindings:
#> • some_junk_in_the_environment: <dbl>
```

To avoid carrying possible junk around in our production pipeline,
whether it be associated with an
[`lm()`](https://rdrr.io/r/stats/lm.html) model (or something more
complex), we can leverage
[`axe_env()`](https://butcher.tidymodels.org/reference/axe_env.md) from
the butcher package:

``` r
cleaned_lm <- axe_env(big_lm, verbose = TRUE)
#> ✔ Memory released: 8.00 MB
```

Comparing it against our `old_lm`, we find:

``` r
weigh(cleaned_lm, threshold = 0, units = "MB")
#> # A tibble: 25 × 2
#>    object            size
#>    <chr>            <dbl>
#>  1 terms         0.00771 
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

And now it takes the same memory on disk:

``` r
weigh(old_lm, threshold = 0, units = "MB")
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

Axing the environment, however, is not the only functionality of
butcher. This package provides five S3 generics that include:

- [`axe_call()`](https://butcher.tidymodels.org/reference/axe_call.md):
  Remove the call object.
- [`axe_ctrl()`](https://butcher.tidymodels.org/reference/axe_ctrl.md):
  Remove the controls fixed for training.
- [`axe_data()`](https://butcher.tidymodels.org/reference/axe_data.md):
  Remove the original data.
- [`axe_env()`](https://butcher.tidymodels.org/reference/axe_env.md):
  Replace inherited environments with empty environments.
- [`axe_fitted()`](https://butcher.tidymodels.org/reference/axe_fitted.md):
  Remove fitted values.

In our case here with [`lm()`](https://rdrr.io/r/stats/lm.html), if we
are only interested in prediction as the end product of our modeling
pipeline, we could free up a lot of memory if we execute all the
possible axe functions at once. To do so, we simply run
[`butcher()`](https://butcher.tidymodels.org/reference/butcher.md):

``` r
butchered_lm <- butcher(big_lm)
predict(butchered_lm, mtcars[, 2:11])
#>           Mazda RX4       Mazda RX4 Wag          Datsun 710 
#>            22.59951            22.11189            26.25064 
#>      Hornet 4 Drive   Hornet Sportabout             Valiant 
#>            21.23740            17.69343            20.38304 
#>          Duster 360           Merc 240D            Merc 230 
#>            14.38626            22.49601            24.41909 
#>            Merc 280           Merc 280C          Merc 450SE 
#>            18.69903            19.19165            14.17216 
#>          Merc 450SL         Merc 450SLC  Cadillac Fleetwood 
#>            15.59957            15.74222            12.03401 
#> Lincoln Continental   Chrysler Imperial            Fiat 128 
#>            10.93644            10.49363            27.77291 
#>         Honda Civic      Toyota Corolla       Toyota Corona 
#>            29.89674            29.51237            23.64310 
#>    Dodge Challenger         AMC Javelin          Camaro Z28 
#>            16.94305            17.73218            13.30602 
#>    Pontiac Firebird           Fiat X1-9       Porsche 914-2 
#>            16.69168            28.29347            26.15295 
#>        Lotus Europa      Ford Pantera L        Ferrari Dino 
#>            27.63627            18.87004            19.69383 
#>       Maserati Bora          Volvo 142E 
#>            13.94112            24.36827
```

Alternatively, we can pick and choose specific axe functions, removing
only those parts of the model object that we are no longer interested in
characterizing.

``` r
butchered_lm <- big_lm |>
  axe_env() |> 
  axe_fitted()
predict(butchered_lm, mtcars[, 2:11])
#>           Mazda RX4       Mazda RX4 Wag          Datsun 710 
#>            22.59951            22.11189            26.25064 
#>      Hornet 4 Drive   Hornet Sportabout             Valiant 
#>            21.23740            17.69343            20.38304 
#>          Duster 360           Merc 240D            Merc 230 
#>            14.38626            22.49601            24.41909 
#>            Merc 280           Merc 280C          Merc 450SE 
#>            18.69903            19.19165            14.17216 
#>          Merc 450SL         Merc 450SLC  Cadillac Fleetwood 
#>            15.59957            15.74222            12.03401 
#> Lincoln Continental   Chrysler Imperial            Fiat 128 
#>            10.93644            10.49363            27.77291 
#>         Honda Civic      Toyota Corolla       Toyota Corona 
#>            29.89674            29.51237            23.64310 
#>    Dodge Challenger         AMC Javelin          Camaro Z28 
#>            16.94305            17.73218            13.30602 
#>    Pontiac Firebird           Fiat X1-9       Porsche 914-2 
#>            16.69168            28.29347            26.15295 
#>        Lotus Europa      Ford Pantera L        Ferrari Dino 
#>            27.63627            18.87004            19.69383 
#>       Maserati Bora          Volvo 142E 
#>            13.94112            24.36827
```

The butcher package provides tooling to axe parts of the fitted output
that are no longer needed, without sacrificing much functionality from
the original model object.
