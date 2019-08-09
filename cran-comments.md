## Resubmission

This a resubmission of butcher based on the improvements suggested: 

```
Thanks, please add a few more examples in your Rd-help-files for the 
users. Since you have tests, you can wrap the additional examples in 
donttest.
```

I have added extra examples for each set of axe methods. 

```
You are using installed.packages():
"This needs to read several files per installed package, which will be 
slow on Windows and on some network-mounted file systems.
It will be slow when thousands of packages are installed, so do not use 
it to find out if a named package is installed (use find.package or 
system.file) nor to find out if a package is usable (call 
requireNamespace or require and check the return value) nor to find 
details of a small number of packages (use packageDescription)."
[installed.packages() help page]
```

I replaced the use of `installed.packages()`.  

## Test environments

* local OS X install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
