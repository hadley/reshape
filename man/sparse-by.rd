
\name{sparseby}
\alias{sparseby}
\title{Apply a Function to a Data Frame split by levels of indices}
\description{
 Function \code{sparseby} is a modified version of \code{\link{by}} for
 \code{\link{tapply}} applied to data frames.  It always returns
 a new data frame rather than a multi-way array. }
\usage{
sparseby(data, INDICES = list(), FUN, ..., GROUPNAMES = TRUE)
}
\arguments{
 \item{data}{an \R object, normally a data frame, possibly a matrix.}
 \item{INDICES}{ a variable or list of variables indicating the subgroups of \code{data} }
 \item{FUN}{a function to be applied to data frame subsets of \code{data}.}
 \item{\dots}{further arguments to \code{FUN}.}
 \item{GROUPNAMES}{a logical variable indicating whether the group names should be
 bound to the result}
}
\details{

A data frame or matrix is split by row into data frames or matrices respectively subsetted by the values of one or more factors, and function \code{FUN} is applied to each subset in turn.

\code{sparseby} is much faster and more memory efficient than \code{\link{by}} or \code{\link{tapply}} in the situation where the combinations of \code{INDICES} present in the data form a sparse subset of all possible combinations.

}

\value{ 

A data frame or matrix containing the results of \code{FUN} applied to each subgroup of the matrix. The result depends on what is returned from \code{FUN}:

If \code{FUN} returns \code{NULL} on any subsets, those are dropped.

If it returns a single value or a vector of values, the length must be consistent across all subgroups. These will be returned as values in rows of the resulting data frame or matrix.

If it returns data frames or matrices, they must all have the same number of columns, and they will be bound with \code{\link{rbind}} into a single data frame or matrix.

Names for the columns will be taken from the names in the list of \code{INDICES} or from the results of \code{FUN}, as appropriate.

}
\author{Duncan Murdoch}
\seealso{ \code{\link{tapply}}, \code{\link{by}} }
\examples{
x <- data.frame(index=c(rep(1,4),rep(2,3)),value=c(1:7))
x
sparseby(x,x$index,nrow)

# The version below works entirely in matrices
x <- as.matrix(x)
sparseby(x,list(group = x[,"index"]), function(subset) c(mean=mean(subset[,2])))
}
\keyword{ iteration }
\keyword{ category }
