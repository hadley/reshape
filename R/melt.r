# Melt
# Melt an object into a form suitable for easy casting.
#
# This the generic melt function. See the following functions
# for specific details for different data structures:
#
# \itemize{
# 	\item \code{\link{melt.data.frame}} for data.frames
# 	\item \code{\link{melt.array}} for arrays, matrices and tables
# 	\item \code{\link{melt.list}} for lists
# }
#
# @keyword manip
# @arguments Data set to melt
# @arguments Other arguments passed to the specific melt method
melt <- function(data, ...) UseMethod("melt", data)

# Default melt function
#
# @keyword internal
melt.default <- function(data, ...) {
	data.frame(value=data)
}

# Melt a list
# Melting a list recursively melts each component of the list and joins the results together
# 
# @keyword internal
#X a <- as.list(1:4)
#X melt(a)
#X names(a) <- letters[1:4]
#X melt(a)
#X attr(a, "varname") <- "ID"
#X melt(a)
#X a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
#X melt(a)
#X a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
#X melt(a)
#X melt(list(1:5, matrix(1:4, ncol=2)))
#X melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))
melt.list <- function(data, ..., level=1) {
	var <- nulldefault(attr(data, "varname"), paste("L", level, sep=""))
	names <- nulldefault(names(data), 1:length(data))
	parts <- lapply(data, melt, level=level+1, ...)
	
	namedparts <- mapply(function(x, name) {
	 x[[var]] <- name
	 x 
	}, parts, names, SIMPLIFY=FALSE)
	do.call(rbind.fill, namedparts)
}

# Melt a data frame
# Melt a data frame into form suitable for easy casting.
#
# You need to tell melt which of your variables are id variables, and which
# are measured variables. If you only supply one of \code{id.var} and
# \code{measure.var}, melt will assume the remainder of the variables in the
# data set belong to the other. If you supply neither, melt will assume
# integer and factor variables are id variables, and all other are measured.
#
# @arguments Data set to melt
# @arguments Id variables. If blank, will use all non measure.var variables
# @arguments Measured variables. If blank, will use all non id.var variables
# @arguments Name of the variable that will store the names of the original variables
# @arguments Should NAs be removed from the data set?
# @arguments Old argument name, now deprecated
# @value molten data
# @keyword manip
# @seealso \url{http://had.co.nz/reshape/}
#X head(melt(tips))
#X names(airquality) <- tolower(names(airquality))
#X melt(airquality, id=c("month", "day"))
#X names(ChickWeight) <- tolower(names(ChickWeight))
#X melt(ChickWeight, id=2:4)
melt.data.frame <- function(data, id.var, measure.var, variable_name = "variable", na.rm = !preserve.na, preserve.na = TRUE, ...) {
	if (!missing(preserve.na)) message("Use of preserve.na is now deprecated, please use na.rm instead")
	remove.na <- function(df) if (!na.rm) df else df[complete.cases(df),,drop=FALSE]

	var <- melt_check(data, id.var, measure.var)
	
	if (length(var$measure) == 0) {
		return(remove.na(data[, var$id, drop=FALSE]))
	}
	
	ids <- data[,var$id, drop=FALSE]
	df <- do.call("rbind", lapply(var$measure, function(x) {
		data.frame(ids, x, data[, x])
	}))
	names(df) <- c(names(ids), variable_name, "value")

	df[[variable_name]] <- factor(df[[variable_name]], unique(df[[variable_name]])) 
	df <- remove.na(df)
	rownames(df) <- NULL
	df
}

# Melt an array
# This function melts a high-dimensional array into a form that you can use \code{\link{cast}} with.
#
# @arguments array to melt
# @arguments variable names to use in molten data.frame
# @keyword manip
# @alias melt.matrix
# @alias melt.table
#X a <- array(1:24, c(2,3,4))
#X melt(a)
#X melt(a, varnames=c("X","Y","Z"))
#X dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
#X melt(a)
#X melt(a, varnames=c("X","Y","Z"))
#X dimnames(a)[1] <- list(NULL)
#X melt(a)
melt.array <- function(data, varnames = names(dimnames(data)), ...) {
	values <- as.vector(data)
	
	dn <- dimnames(data)
	if (is.null(dn)) dn <- vector("list", length(dim(data)))

	dn_missing <- sapply(dn, is.null)
	dn[dn_missing] <- lapply(dim(data), function(x) 1:x)[dn_missing]
	indicies <- do.call(expand.grid, dn)

	names(indicies) <- varnames
	data.frame(indicies, value=values)
}

melt.table <- melt.array
melt.matrix <- melt.array

# Melt cast data.frames
# After casting into a particular form, it can sometimes be useful to 
# 
# @keyword internal
melt.cast_df <- function(data, drop.margins=TRUE, ...) {
	molten <- melt.data.frame(as.data.frame(data), id=attr(data, "idvars"))
	
	cols <- rcolnames(data)
	rownames(cols) <- make.names(rownames(cols))

	molten <- cbind(molten[names(molten) != "variable"], cols[molten$variable, , drop=FALSE])
	
	if (drop.margins) {
			margins <- !complete.cases(molten[,names(molten) != "value", drop=FALSE])
		molten <- molten[!margins, ]
	}

	molten

}

# Melt cast matrices
# 
# @keyword internal
melt.cast_matrix <- function(data, ...) {
	melt(as.data.frame(data))
}

# Melt check.
# Check that input variables to melt are appropriate.
#
# If id.var or measure.var are missing, \code{melt_check }will do its 
# best to impute them.If you only 
# supply one of id.var and measure.var, melt will assume the remainder of 
# the variables in the data set belong to the other. If you supply neither, 
# melt will assume character and factor variables are id variables, 
# and all other are measured. 
#
# @keyword internal
# @arguments data frame
# @arguments Vector of identifying variable names or indexes
# @arguments Vector of Measured variable names or indexes
# @value id list id variable names
# @value measure list of measured variable names
melt_check <- function(data, id.var, measure.var) {
	varnames <- names(data)
	if (!missing(id.var) && is.numeric(id.var)) id.var <- varnames[id.var]
	if (!missing(measure.var) && is.numeric(measure.var)) measure.var <- varnames[measure.var]
	
	if (!missing(id.var)) {
		unknown <- setdiff(id.var, varnames)
		if (length(unknown) > 0) {
			stop("id variables not found in data: ", paste(unknown, collapse=", "), 
			  call. = FALSE)
		}
	} 
	
	if (!missing(measure.var)) {
		unknown <- setdiff(measure.var, varnames)
		if (length(unknown) > 0) {
			stop("measure variables not found in data: ", paste(unknown, collapse=", "), 
			  call. = FALSE)
		}
	} 

	if (missing(id.var) && missing(measure.var)) {
		categorical <- sapply(data, function(x) class(x)[1]) %in% c("factor", "ordered", "character")
		id.var <- varnames[categorical]
		measure.var <- varnames[!categorical]
		message("Using ", paste(id.var, collapse=", "), " as id variables")
	} 

	if (missing(id.var)) id.var <- varnames[!(varnames %in% c(measure.var))]
	if (missing(measure.var)) measure.var <- varnames[!(varnames %in% c(id.var))]
	
	list(id = id.var, measure = measure.var)	
}
