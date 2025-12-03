# Axing an flexsurvreg.

flexsurvreg objects are created from the flexsurv package. They differ
from survreg in that the fitted models are not limited to certain
parametric distributions. Users can define their own distribution, or
leverage distributions like the generalized gamma, generalized F, and
the Royston-Parmar spline model.

## Usage

``` r
# S3 method for class 'flexsurvreg'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'flexsurvreg'
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

Axed flexsurvreg object.

## Examples

``` r
# Load libraries
library(parsnip)
library(censored)
library(flexsurv)

# Create model and fit
flexsurvreg_fit <- survival_reg(dist = "gengamma") %>%
  set_engine("flexsurv") %>%
  set_mode("censored regression") %>%
  fit(Surv(Tstart, Tstop, status) ~ trans, data = bosms3)

out <- butcher(flexsurvreg_fit, verbose = TRUE)
#> ✖ The butchered object is 3.68 kB larger than the original. Do not butcher.

# Another flexsurvreg model object
wrapped_flexsurvreg <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- flexsurvreg(Surv(futime, fustat) ~ 1,
                     data = ovarian, dist = "weibull")
  return(fit)
}

out <- butcher(wrapped_flexsurvreg(), verbose = TRUE)
#> ✖ The butchered object is 2.83 kB larger than the original. Do not butcher.
```
