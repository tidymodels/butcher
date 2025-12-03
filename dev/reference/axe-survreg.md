# Axing an survreg.

survreg objects are created from the survival package. They are returned
from the `survreg` function, representing fitted parametric survival
models.

## Usage

``` r
# S3 method for class 'survreg'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'survreg'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'survreg'
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

Axed survreg object.

## Examples

``` r
# Load libraries
library(parsnip)
library(survival)

# Create model and fit
survreg_fit <- survival_reg(dist = "weibull") %>%
  set_engine("survival") %>%
  fit(Surv(futime, fustat) ~ 1, data = ovarian)

out <- butcher(survreg_fit, verbose = TRUE)
#> ✖ The butchered object is 3.42 kB larger than the original. Do not butcher.

# Another survreg object
wrapped_survreg <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- survreg(Surv(time, status) ~ ph.ecog + age + strata(sex),
                 data = lung)
  return(fit)
}

# Remove junk
cleaned_survreg <- butcher(wrapped_survreg(), verbose = TRUE)
#> ✔ Memory released: 9.70 MB
#> ✖ Disabled: `print()`, `summary()`, and `residuals()`

# Check size
lobstr::obj_size(cleaned_survreg)
#> 11.58 kB
```
