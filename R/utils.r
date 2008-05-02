# Guess name of value column
# 
# Strategy:
# \enumerate{
# 	\item Is value or (all) column present? If so, use that
# 	\item Otherwise, guess that last column is the value column
# }
# @arguments Data frame to guess value column from
# @keyword internal
guess_value <- function(df) {
	if ("value" %in% names(df)) return("value")
	if ("(all)" %in% names(df)) return("(all)")
	
	last <- names(df)[ncol(df)]
	message("Using ", last, " as value column.  Use the value argument to cast to override this choice")
	
	last
}

# Merge together a series of data.frames
#
# Order of data frames should be from most complete to least complete 
#
# @arguments list of data frames to merge
# @seealso \code{\link{merge_recurse}}
# @keyword manip
merge_all <- function(dfs, ...) {
	if (length(dfs)==1) return(dfs[[1]])
	df <- merge_recurse(dfs, ...)
	df <- df[, match(names(dfs[[1]]), names(df))]
	df[do.call("order", df[, -ncol(df), drop=FALSE]), ,drop=FALSE]
}

# Recursively merge data frames
#
# @arguments list of data frames to merge
# @seealso \code{\link{merge_all}}
# @keyword internal
merge_recurse <- function(dfs, ...) {
	if (length(dfs) == 2) {
		merge(dfs[[1]], dfs[[2]], all=TRUE, sort=FALSE, ...)
	} else {
		merge(dfs[[1]], Recall(dfs[-1]), all=TRUE, sort=FALSE, ...)
	}
}

# expand grid
# expand grid of data frames
#
# Creates new data frame containing all combination of rows from
# data.frames in \code{...}
#
# @arguments list of data frames (first varies fastest)
# @arguments only use unique rows?
# @keyword manip
#X expand.grid.df(data.frame(a=1,b=1:2))
#X expand.grid.df(data.frame(a=1,b=1:2), data.frame())
#X expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2))
#X expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2), data.frame(e=c("a","b")))
expand.grid.df <- function(..., unique=TRUE) {
	dfs <- list(...)

	notempty <- sapply(dfs, ncol) != 0
	if (sum(notempty) == 1) return(dfs[notempty][[1]])

	if (unique) dfs <- lapply(dfs, unique)
	indexes <- lapply(dfs, function(x) 1:nrow(x))

	grid <- do.call(expand.grid, indexes)
	df <- do.call(data.frame, mapply(function(df, index) df[index, ,drop=FALSE], dfs, grid))
	colnames(df) <- unlist(lapply(dfs, colnames))
	rownames(df) <- 1:nrow(df)
	
	return(df)
}


# Rbind fill
# Rbind a list of data frames filling missing columns with NA 
#
# @arguments data frames to row bind together
# @keyword manip
rbind.fill <- function(...) {
	dfs <- list(...)
	if (length(dfs) == 0) return(list())

	all.names <- unique(unlist(lapply(dfs, names)))
	do.call("rbind", compact(lapply(dfs, function(df) {
		if (length(df) == 0 || nrow(df) == 0) return(NULL)
		
 		missing.vars <- setdiff(all.names, names(df))
		if (length(missing.vars) > 0) df[, missing.vars] <- NA
		df
	})))
}

# Compact list
# Remove all NULL entries from a list
# 
# @arguments list
# @keyword manip 
compact <- function(l) {
  l[!sapply(l, is.null)]
}

# Defaults
# Convient method for combining a list of values with their defaults.
# 
# @arguments list of values
# @arguments defaults
# @keyword manip 
defaults <- function(x, y)  {
	c(x, y[setdiff(names(y), names(x))])
} 


# Sort data frame
# Convenience method for sorting a data frame using the given variables.
# 
# @arguments data frame to sort
# @arguments variables to use for sorting
# @returns sorted data frame
# @keyword manip 
sort_df <- function(data, vars=names(data)) {
	if (length(vars) == 0 || is.null(vars)) return(data)
	data[do.call("order", data[,vars, drop=FALSE]), ,drop=FALSE]
}


# Untable a dataset
# Given a tabulated dataset (or matrix) this will untabulate it
# by repeating each row by the number of times it was repeated
# 
# @arguments matrix or data.frame to untable
# @arguments vector of counts (of same length as \code{df})
# @keyword manip 
untable <- function(df, num) {
	df[rep(1:nrow(df), num), ]
}



# Unique default
# Convenience function for setting default if not unique
# 
# @arguments vector of values
# @arguments default to use if values not uniquez
# @keyword manip 
uniquedefault <- function(values, default) {
	unq <- unique(values)
	if (length(unq) == 1) unq[1] else "black"
}

# Rename
# Rename an object
# 
# The rename function provide an easy way to rename the columns of a
# data.frame or the items in a list.
# 
# @arguments object to be renamed
# @arguments named vector specifying new names
# @keyword manip
#X rename(mtcars, c(wt = "weight", cyl = "cylinders"))
#X a <- list(a = 1, b = 2, c = 3)
#X rename(a, c(b = "a", c = "b", a="c"))
rename <- function(x, replace) {
	replacement <-  replace[names(x)]
	names(x)[!is.na(replacement)] <- replacement[!is.na(replacement)]
	x
}

# Round any
# Round to multiple of any number
# 
# @arguments numeric vector to round
# @arguments number to round to
# @arguments function to use for round (eg. \code{\link{floor}})
# @keyword internal 
#X round_any(135, 10)
#X round_any(135, 100)
#X round_any(135, 25)
#X round_any(135, 10, floor)
#X round_any(135, 100, floor)
#X round_any(135, 25, floor)
#X round_any(135, 10, ceiling)
#X round_any(135, 100, ceiling)
#X round_any(135, 25, ceiling)
round_any <- function(x, accuracy, f=round) {
	f(x / accuracy) * accuracy
}


# Update list
# Update a list, but don't create new entries
# 
# @arguments list to be updated
# @arguments list with updated values
# @keyword internal 
updatelist <- function(x, y)  {
	common <- intersect(names(x),names(y))
	x[common] <- y[common]
	x
} 


# Nested.by function
# 
# @keyword internal
nested.by <- function(data, INDICES, FUN, ...) {
	if (length(compact(INDICES)) == 0 || is.null(INDICES)) return(FUN(data, ...))
	
	FUNx <- function(x) FUN(data[x, ], ...)
	nd <- nrow(data)

	if (length(INDICES) == 1) {
		return(with(data, tapply(1:nd, INDICES[[1]], FUNx)))
	}

	tapply(1:nd, INDICES[[length(INDICES)]], function(x) {
		nested.by(data[x, ], lapply(INDICES[-length(INDICES)],"[", x), FUN, ...)
	}, simplify=FALSE)
}


# Split a vector into multiple columns
# This function can be used to split up a column that has been pasted together.
# 
# @arguments character vector or factor to split up
# @arguments regular expression to split on
# @arguments names for output columns
# @keyword manip
# @alias colsplit.factor
# @alias colsplit.character
colsplit <- function(x, split="", names) UseMethod("colsplit", x)
colsplit.factor <- function(x, split="", names) colsplit(as.character(x), split, names)
colsplit.character <- function(x, split="", names) {
	vars <- as.data.frame(do.call(rbind, strsplit(x, split)))
	names(vars) <- names
	as.data.frame(lapply(vars, function(x) type.convert(as.character(x))))
}

# Aggregate multiple functions into a single function
# Combine multiple functions to a single function returning a named vector of outputs
# 
# Each function should produce a single number as output
# 
# @arguments functions to combine
# @keyword manip
#X funstofun(min, max)(1:10)
#X funstofun(length, mean, var)(rnorm(100))
funstofun <- function(...) {
  fnames <- sapply(match.call()[-1], deparse)
  fs <- list(...)
  n <- length(fs)
  
  function(x, ...) {
    results <- vector("numeric", length=n)
    for(i in 1:n) results[[i]] <- fs[[i]](x, ...)
    names(results) <- fnames
    results
  }
}

# Use default value when null
#
# @keyword internal
nulldefault <- function(x, default) {
  if (is.null(x)) default else x
}


namerows <- function(df, col.name = "id") {
	df[[col.name]] = rownames(df)
	df
}

# Number of unique values
# Calculate number of unique values of a variable as efficiently as possible.
# 
# @arguments vector
# @keyword internal
nunique <- function(x) {
  if (is.factor(x)) {
    length(levels(x))
  } else {
    length(unique(x))
  }
}
