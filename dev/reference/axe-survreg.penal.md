# Axing an survreg.penal

survreg.penal objects are created from the survival package. They are
returned from the `survreg` function, representing fitted parametric
survival models.

## Usage

``` r
# S3 method for class 'survreg.penal'
axe_call(x, verbose = FALSE, ...)

# S3 method for class 'survreg.penal'
axe_data(x, verbose = FALSE, ...)

# S3 method for class 'survreg.penal'
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
  fit(Surv(time, status) ~ rx, data = rats)

out <- butcher(survreg_fit, verbose = TRUE)
#> ✖ The butchered object is 3.49 kB larger than the original. Do not butcher.

# Another survreg.penal object
wrapped_survreg.penal <- function() {
  some_junk_in_environment <- runif(1e6)
  fit <- survreg(Surv(time, status) ~ rx,
                 data = rats, subset = (sex == "f"))
  return(fit)
}

# Remove junk
cleaned_sp <- axe_env(wrapped_survreg.penal(), verbose = TRUE)
#> ✔ Memory released: 9.68 MB

# Check size
lobstr::obj_size(cleaned_sp)
#> 13.74 kB
```
