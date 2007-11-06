# Idempotent apply
# A version of apply that works like apply, but returns the array in the same shape as the original.  This is useful in conjunction with \code{\link{stamp}}.
# 
# iapply is idempotent in the sense that \code{iapply(x, a, function(x) x)}
# will always return \code{x} for any value \code{a}.  This is different
# to apply, which returns a permutation of the original matrix.
#
# \code{fun} should return an array, matrix or vector.
# 
# @arguments array
# @arguments margins to apply over
# @arguments function to apply
# @arguments other arguments pass to function
# @arguments remove extraneous (length 1) dimensions?
# @arguments use original dimnames?
# @argument reorder 
# @seealso \code{\link{apply}} for the function which this is based on 
# @keyword manip 
#X a <- array(1:27, c(2,3,4))
#X all.equal(a, iapply(a, 1, force))
#X all.equal(a, iapply(a, 2, force))
#X all.equal(a, iapply(a, 3, force))
#X all.equal(a, iapply(a, 1:2, force))
#X all.equal(aperm(a, c(2,1,3)), iapply(a, 2, force, REORDER=FALSE))
#X all.equal(aperm(a, c(3,1,2)), iapply(a, 3, force, REORDER=FALSE))
#X 
#X iapply(a, 1, min)
#X iapply(a, 1, min, DROP=TRUE)
#X iapply(a, 2, min)
#X iapply(a, 2, min, DROP=TRUE)
#X iapply(a, 3, min)
#X iapply(a, 3, min, DROP=TRUE)
#X iapply(a, 1, range)
#X iapply(a, 2, range)
#X iapply(a, 3, range)
#X
#X mina <- iapply(a, 1, min)
#X sweep(a, 1, mina)
#X mina <- iapply(a, c(1,3), min)
#X sweep(a, c(1,3), mina)
iapply <- function(x, margins=1, fun, ..., DROP=FALSE, COPY.DIMNAMES=FALSE, REORDER=TRUE) { 
	if (!is.array(x)) x <- as.array(x)
	olddim <- dim(x)
	olddimnames <- dimnames(x)
	
	reorder <- c(margins, (1:length(dim(x)))[-margins])

	x <- aperm(x, reorder)
	x <- compactify(x, length(margins))

	results <- lapply(x, fun, ...)
	dim(results) <- dim(x)
	
	results <- decompactify(results)
	
	if (REORDER) {
	  dim(results) <- c(dim(results), rep(1, length(reorder) - length(dim(results))))
	  results <- aperm(results, reorder)
	}
	if (COPY.DIMNAMES && identical(olddim, dim(results))) dimnames(results) <- olddimnames
	if (DROP) reduce(results) else results
}


# Compactify
# Compacts an array into a smaller array of lists containing the remaining dimensions
# 
# @arguments array
# @arguments number of dimension to compact
# @keyword internal 
compactify <- function(x, dims = 1) {

	d <- dim(x)
	ds <- seq(along=d)
	margins <- 1:dims
	
	subsets <- do.call(expand.grid, structure(lapply(d[margins], seq, from=1), names=margins))
	subsets[, ds[-margins]] <- TRUE
	
	res <- lapply(1:nrow(subsets), function(i) do.call("[",c(list(x), subsets[i, ], drop=TRUE)))
	dim(res) <- dim(x)[margins]
	
	res
}

# Decompactify
# Inverse of \code{\link{compactify}}
# 
# @arguments list array
# @keyword internal 
decompactify <- function(x) {

	subsets <- do.call(expand.grid, structure(lapply(dim(x), seq, from=1)))
	subsets <- cbind(subsets, x=matrix(TRUE, ncol=length(vdim(x[[1]])), nrow=nrow(subsets)))

	y <- array(NA, c(vdim(x), vdim(x[[1]])))
	for(i in 1:length(x)) {
		y <- do.call("[<-",c(list(y), unname(subsets[i, ]), value = list(x[[i]])))
	}
	y
}

# Reduce dimensions
# Remove extraneous dimensions
# 
# @arguments array
# @keyword internal 
reduce <- function(x) {
		do.call("[", c(list(x), lapply(dim(x), function(x) if (x==1) 1 else T), drop=TRUE))	
}
