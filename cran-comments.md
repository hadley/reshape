## Test environments
* local OS X install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs or NOTEs. 

## Downstream dependencies
I have run R CMD check on all 141 downstream dependencies of reshape2. (https://github.com/hadley/reshape/blob/master/revdep/summary.md). I have carefully reviewed the output and I do not believe there are any new failures related to reshape2. This is likely because this version only includes three bug fixes for edge cases of one function.

A number of the downstream dependencies produce a large number of NOTEs. I have notified the worst offenders and suggested that they fix the problems. This includes a couple of packages that I'm at least partly responsible for, so you'll see updates for these soon.
