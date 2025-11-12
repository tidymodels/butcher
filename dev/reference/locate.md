# Locate part of an object.

Locate where a specific component of a object might exist within the
model object itself. This function is restricted in that only items that
can be axed can be found.

## Usage

``` r
locate(x, name = NULL)
```

## Arguments

- x:

  A model object.

- name:

  A name associated with model component of interest. This defaults to
  NULL. Possible components include: `env`, `call`, `data`, `ctrl`, and
  `fitted`.

## Value

Location of specific component in a model object.

## Examples

``` r
lm_fit <- lm(mpg ~ ., data = mtcars)
locate(lm_fit, name = "env")
#> [1] "x$terms"
locate(lm_fit, name = "call")
#> [1] "x$call"
```
