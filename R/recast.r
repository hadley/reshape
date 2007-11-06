# Recast 
# \link{melt} and \link{cast} data in a single step
# 
# This conveniently wraps melting and casting a data frame into
# one step. 
#
# @arguments Data set to melt
# @arguments Casting formula, see \link{cast} for specifics
# @arguments Other arguments passed to \link{cast}
# @arguments Identifying variables. If blank, will use all non measure.var variables
# @arguments Measured variables. If blank, will use all non id.var variables
# @keyword manip
# @seealso \url{http://had.co.nz/reshape/}
#X recast(french_fries, time ~ variable, id.var=1:4)
recast <- function(data, formula, ..., id.var, measure.var) {
	#var <- unlist(cast_parse_formula(deparse(substitute(formula)), names(data)))
	#used <- intersect(names(data), union(var, measure.var))

	molten <- melt(data, id.var, measure.var)
	cast(molten, deparse(substitute(formula)), ...)
}
