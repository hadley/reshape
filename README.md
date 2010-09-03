Reshape2 is a reboot of the reshape package.  It's been over five years since the first release of the package, and in that time I've learned a tremendous amount about R programming, and how to work with data in R.  Reshape2 uses that knowledge to make a new package for reshaping data that is much more focussed and much much faster.

Compared to reshape, reshape2:

 * is considerably faster and more memory efficient thanks to a much better
   underlying algorithm that uses the power and speed of subsetting to the
   fullest extent

 * only provides two functions: melt and cast

 * drops support for the | cast operator (because this is what plyr is for)

 * supports a new cast syntax which allows you to reshape based on functions
   of variables (based on the same underlying syntax as plyr)
