## Resubmission

This a resubmission of butcher based on the improvements suggested: 

```
Thanks,

\dontrun{} should be only used if the example really cannot be executed 
(e.g. because of missing additional software, missing API keys, ...) by 
the user. That's why wrapping examples in \dontrun{} adds the comment 
("# Not run:") as a warning for the user.
Please replace \dontrun{} with \donttest.
```

I replaced all the examples wrapped in `dontrun` with `donttest`. 

## Test environments

* local OS X install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
