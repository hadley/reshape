# Cast function
# Cast a molten data frame into the reshaped or aggregated form you want
#
# Along with \code{\link{melt}}  and \link{recast}, this is the only function you should ever need to use.
# Once you have melted your data, cast will arrange it into the form you desire
# based on the specification given by \code{formula}.
#
# The cast formula has the following format: \code{x_variable + x_2 ~ y_variable + y_2 ~ z_variable ~  ... | list_variable + ... }
# The order of the variables makes a difference.  The first varies slowest, and the last 
# fastest.  There are a couple of special variables: "..." represents all other variables 
# not used in the formula and "." represents no variable, so you can do \code{formula=var1 ~ .}
#
# Creating high-D arrays is simple, and allows a class of transformations that are hard
# without \code{\link{iapply}} and \code{\link{sweep}} 
#
# If the combination of variables you supply does not uniquely identify one row in the 
# original data set, you will need to supply an aggregating function, \code{fun.aggregate}.
# This function should take a vector of numbers and return a summary statistic(s).  It must
# return the same number of arguments regardless of the length of the input vector.
# If it returns multiple value you can use "result\_variable" to control where they appear.
# By default they will appear as the last column variable.
#
# The margins argument should be passed a vector of variable names, eg.
# \code{c("month","day")}.  It will silently drop any variables that can not be margined 
# over.  You can also use "grand\_col" and "grand\_row" to get grand row and column margins
# respectively.
#
# Subset takes a logical vector that will be evaluated in the context of \code{data},
# so you can do something like \code{subset = variable=="length"}
#
# All the actual reshaping is done by \code{\link{reshape1}}, see its documentation
# for details of the implementation
#
# @keyword manip
# @arguments molten data frame, see \code{\link{melt}}
# @arguments casting formula, see details for specifics
# @arguments aggregation function
# @arguments further arguments are passed to aggregating function
# @arguments vector of variable names (can include "grand\_col" and "grand\_row") to compute margins for, or TRUE to computer all margins
# @arguments logical vector to subset data set with before reshaping
# @arguments argument used internally
# @arguments value with which to fill in structural missings
# @argument should all missing combinations be displayed?
# @argument name of column which stores values, see \code{\link{guess_value}} for default strategies to figure this out
# @seealso \code{\link{reshape1}},  \url{http://had.co.nz/reshape/}
#X #Air quality example
#X names(airquality) <- tolower(names(airquality))
#X aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
#X 
#X cast(aqm, day ~ month ~ variable)
#X cast(aqm, month ~ variable, mean)
#X cast(aqm, month ~ . | variable, mean)
#X cast(aqm, month ~ variable, mean, margins=c("grand_row", "grand_col"))
#X cast(aqm, day ~ month, mean, subset=variable=="ozone")
#X cast(aqm, month ~ variable, range)
#X cast(aqm, month ~ variable + result_variable, range)
#X cast(aqm, variable ~ month ~ result_variable,range)
#X
#X #Chick weight example
#X names(ChickWeight) <- tolower(names(ChickWeight))
#X chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
#X 
#X cast(chick_m, time ~ variable, mean) # average effect of time
#X cast(chick_m, diet ~ variable, mean) # average effect of diet
#X cast(chick_m, diet ~ time ~ variable, mean) # average effect of diet & time
#X 
#X # How many chicks at each time? - checking for balance
#X cast(chick_m, time ~ diet, length)
#X cast(chick_m, chick ~ time, mean)
#X cast(chick_m, chick ~ time, mean, subset=time < 10 & chick < 20)
#X 
#X cast(chick_m, diet + chick ~ time)
#X cast(chick_m, chick ~ time ~ diet)
#X cast(chick_m, diet + chick ~ time, mean, margins="diet")
#X
#X #Tips example
#X cast(melt(tips), sex ~ smoker, mean, subset=variable=="total_bill")
#X cast(melt(tips), sex ~ smoker | variable, mean)
#X 
#X ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
#X cast(ff_d, subject ~ time, length)
#X cast(ff_d, subject ~ time, length, fill=0)
#X cast(ff_d, subject ~ time, function(x) 30 - length(x))
#X cast(ff_d, subject ~ time, function(x) 30 - length(x), fill=30)
#X cast(ff_d, variable ~ ., c(min, max))
#X cast(ff_d, variable ~ ., function(x) quantile(x,c(0.25,0.5)))
#X cast(ff_d, treatment ~ variable, mean, margins=c("grand_col", "grand_row"))
#X cast(ff_d, treatment + subject ~ variable, mean, margins="treatment")
#X lattice::xyplot(`1` ~ `2` | variable, cast(ff_d, ... ~ rep), aspect="iso")
cast <- function(data, formula = ... ~ variable, fun.aggregate=NULL, ..., margins=FALSE, subset=TRUE, df=FALSE, fill=NA, add.missing=FALSE, value = guess_value(data)) {
  if (!is.null(fun.aggregate)) fun.aggregate <- match.fun(fun.aggregate)
	if (is.formula(formula))    formula <- deparse(formula)
	if (!is.character(formula)) formula <- as.character(formula)

	subset <- eval(substitute(subset), data, parent.frame())  
	data <- data[subset, , drop=FALSE]  
	variables <- cast_parse_formula(formula, names(data))

  if (any(names(data) == value))  names(data)[names(data) == value] <- "value"

	v <- unlist(variables)
	v <- v[v != "result_variable"]
	if (add.missing) data[v] <- lapply(data[v], as.factor)

	if (length(fun.aggregate) > 1) 
		fun.aggregate <- do.call(funstofun, as.list(match.call()[[4]])[-1])
	
	if (!is.null(variables$l)) {
		res <- nested.by(data, data[variables$l], function(x) {
			castd(x, variables$m, fun.aggregate, margins=margins, df=df, fill=fill, add.missing=add.missing, ...)
		})	
	} else {
		res <- castd(data, variables$m, fun.aggregate, margins=margins, df=df,fill=fill, add.missing=add.missing, ...)
	}
	#attr(res, "formula") <- formula
	#attr(res, "data") <- deparse(substitute(data))
	
	res
}

