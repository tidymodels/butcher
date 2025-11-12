# Weigh the object.

Evaluate the size of each element contained in a model object.

## Usage

``` r
weigh(x, threshold = 0, units = "MB", ...)
```

## Arguments

- x:

  A model object.

- threshold:

  The minimum threshold desired for model component size to display.

- units:

  The units in which to display the size of each component within the
  model object of interest. Defaults to `MB`. Other options include `KB`
  and `GB`.

- ...:

  Any additional arguments for weighing.

## Value

Tibble with weights of object components in decreasing magnitude.

## Examples

``` r
simulate_x <- matrix(runif(1e+6), ncol = 2)
simulate_y <- runif(dim(simulate_x)[1])
lm_out <- lm(simulate_y ~ simulate_x)
weigh(lm_out)
#> # A tibble: 16 × 2
#>    object                size
#>    <chr>                <dbl>
#>  1 terms            53.5     
#>  2 qr.qr            12.0     
#>  3 effects           8.00    
#>  4 model.simulate_x  8.00    
#>  5 residuals         4.00    
#>  6 fitted.values     4.00    
#>  7 model.simulate_y  4.00    
#>  8 call              0.00056 
#>  9 coefficients      0.000464
#> 10 qr.qraux          0.00008 
#> 11 assign            0.000064
#> 12 qr.pivot          0.000064
#> 13 rank              0.000056
#> 14 qr.tol            0.000056
#> 15 qr.rank           0.000056
#> 16 df.residual       0.000056
```
