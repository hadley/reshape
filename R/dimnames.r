# Cast matrix.
# Createa a new cast matrix
# 
# @arguments matrix to turn into cast matrix
# @arguments list of dimension names (as data.frames), row, col, ...
# @value object of type \code{\link{cast_matrix}}
# @keyword internal
cast_matrix <- function(m, dimnames) {
	rdimnames(m) <- dimnames
	class(m) <- c("cast_matrix", class(m))

  dimnames(m) <- lapply(rdimnames(m), rownames)

	m
}

# Dimension names
# These methods provide easy access to the special dimension names
# associated without the output of reshape
# 
# @alias rdimnames<- 
# @alias rcolnames 
# @alias rcolnames<- 
# @alias rrownames 
# @alias rrownames<- 
# @keyword internal
rdimnames <- function(x) attr(x, "rdimnames")
"rdimnames<-" <- function(x, value) {
  
  name <- function(df) {
    rownames(df) <- apply(df, 1, paste, collapse="_")
    df
  }
	
	value <- lapply(value, name)
	attr(x, "rdimnames") <- value
	attr(x, "idvars") <- colnames(value[[1]])
	x
}
rcolnames <- function(x) rdimnames(x)[[2]]
"rcolnames<-" <- function(x, value) {
	dn <- rdimnames(x)
	dn[[2]] <- value
	rdimnames(x) <- dn
	x
}
rrownames <- function(x) rdimnames(x)[[1]]
"rrownames<-" <- function(x, value) {
	dn <- rdimnames(x)
	dn[[1]] <- value
	rdimnames(x) <- dn
	x
}

# Convert cast matrix into a data frame
#
# @argument Reshape matrix
# @argument Argument required to match generic
# @argument Argument required to match generic
# @keyword internal
as.data.frame.cast_matrix <- function(x, row.names, optional, ...) {
	unx <- unclass(x)

	colnames(unx) <- rownames(rcolnames(x))
	
	r.df <- data.frame(rrownames(x), unx, check.names=FALSE)
	class(r.df) <- c("cast_df", "data.frame")
	attr(r.df, "idvars") <- attr(x, "idvars")
	attr(r.df, "rdimnames") <- attr(x, "rdimnames")
	rownames(r.df) <- 1:nrow(r.df)

	r.df
}

# Convert cast data.frame into a matrix
# 
# @keyword internal
as.matrix.cast_df <- function(x, ...) {
	ids <- attr(x, "idvars")
  mat <- as.matrix.data.frame(x[, setdiff(names(x), ids)])
  
	rownames(mat) <- rownames(rrownames(x))
	colnames(mat) <- rownames(rcolnames(x))
	
	attr(mat, "idvars") <- attr(x, "idvars")
	attr(mat, "rdimnames") <- attr(x, "rdimnames")

  class(mat) <- c("cast_matrix", class(mat))
  
  mat
}

# Convert cast matrix into a matrix
# 
# @keyword internal
as.matrix.cast_matrix <- function(x, ...) {
  class(x) <- class(x)[-1]
  x
}

# Convert cast data.frame into a matrix
# 
# @keyword internal
as.data.frame.cast_df <- function(x, ...) {
  class(x) <- class(x)[-1]
  x
}

# Printing methods
# 
# @keyword internal
# @alias str.cast_df
# @alias print.cast_matrix
# @alias print.cast_df
str.cast_df <- str.cast_matrix <- function(object, ...) {
  str(unclass(object))
}

print.cast_matrix <- print.cast_df <- function(x, ...) {
  class(x) <- class(x)[-1]
  attr(x, "idvars") <- NULL
  attr(x, "rdimnames") <- NULL
  NextMethod(x, ...)
}