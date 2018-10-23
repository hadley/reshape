## Test environments
* local OS X install: 3.5.1
* win-builder: devel

## R CMD check results

0 errors | 0 warnings | 2 notes

* checking S3 generic/method consistency ... NOTE
  Found the following apparent S3 methods exported but not registered:
    all.vars.character
  See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
  manual.

* checking Rd \usage sections ... NOTE
  S3 methods shown with full name in documentation object 'all.vars.character':
    ‘all.vars.character’
  
  The \usage entries for S3 methods should use the \method markup and not
  their full name.
  See chapter ‘Writing R documentation files’ in the ‘Writing R
  Extensions’ manual.
  
These two notes appear to be unavoidable with R-release.

## Reverse dependencies

This is a minor update to the fix recently S3 method documentation issue so I did not re-check the reverse dependencies.
