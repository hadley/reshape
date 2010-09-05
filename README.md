Reshape2 is a reboot of the reshape package. It's been over five years since the first release of the package, and in that time I've learned a tremendous amount about R programming, and how to work with data in R. Reshape2 uses that knowledge to make a new package for reshaping data that is much more focussed and much much faster.

Compared to `reshape`, `reshape2`:

 * is considerably faster and more memory efficient thanks to a much better
   underlying algorithm that uses the power and speed of subsetting to the
   fullest extent, in most cases only making a single copy of the data.

 * cast is replaced by two functions depending on the output type: `dcast`
   produces data frames, and `acast` produces matrices/arrays.

 * lacks some features such as the `|` cast operator, and the ability to
   return multiple values from an aggregation function. I'm reasonable sure
   both these operations are better performed by plyr.

 * supports a new cast syntax which allows you to reshape based on functions
   of variables (based on the same underlying syntax as plyr)

Initial benchmarking has shown `melt` to be up to 10x faster, pure reshaping `cast` up to 100x faster, and aggregating `cast()` up to 10x faster.