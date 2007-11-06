# Combine factor levels
# Convenience function to make it easy to combine multiple levels
# in a factor into one.
# 
# @arguments factor variable
# @arguments either a vector of   .  See examples for more details.
# @arguments label for other level
# @keyword manip 
#X df <- data.frame(a = LETTERS[sample(5, 15, replace=TRUE)], y = rnorm(15))	
#X combine_factor(df$a, c(1,2,2,1,2))
#X combine_factor(df$a, c(1:4, 1))
#X (f <- reorder_factor(df$a, tapply(df$y, df$a, mean)))
#X percent <- tapply(abs(df$y), df$a, sum)
#X combine_factor(f, c(order(percent)[1:3]))
combine_factor <- function(fac, variable=levels(fac), other.label="Other") {
	n <- length(levels(fac))
	if (length(variable) < n) {
		nvar <- c(seq(1, length(variable)), rep(length(variable)+1, n - length(variable)))
		factor(nvar[as.numeric(fac)], labels=c(levels(fac)[variable], other.label))
	} else {
		factor(variable[as.numeric(fac)], labels=levels(fac)[!duplicated(variable)])		
	}
} 

# Reorder factor levels
# Convenience method for reordering the levels of a factor
# 
# @arguments factor variable
# @arguments new order 
# @arguments whether should be sorted descreasing
# @keyword manip 
#X df <- data.frame(a = LETTERS[sample(5, 15, replace=TRUE)], y = rnorm(15))	
#X (f <- reorder_factor(df$a, tapply(df$y, df$a, mean)))
#X (f <- reorder_factor(f))
#X reorder_factor(f, c(4,2,3,1,5), dec=TRUE)
reorder_factor <- function(fac, variable=levels(fac), decreasing=FALSE) {
	factor(fac, levels=levels(fac)[order(variable, decreasing=decreasing)])
}
