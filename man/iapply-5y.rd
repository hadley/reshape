\name{iapply}
\alias{iapply}
\title{Idempotent apply}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
A version of apply that works like apply, but returns the array in the same shape as the original.  This is useful in conjunction with \code{\link{stamp}}.
}
\usage{iapply(x, margins=1, fun, ..., DROP=FALSE, COPY.DIMNAMES=FALSE, REORDER=TRUE)}
\arguments{
\item{x}{array}
\item{margins}{margins to apply over}
\item{fun}{function to apply}
\item{...}{other arguments pass to function}
\item{DROP}{remove extraneous (length 1) dimensions?}
\item{COPY.DIMNAMES}{use original dimnames?}
\item{REORDER}{}
}

\details{iapply is idempotent in the sense that \code{iapply(x, a, function(x) x)}
will always return \code{x} for any value \code{a}.  This is different
to apply, which returns a permutation of the original matrix.

\code{fun} should return an array, matrix or vector.}
\seealso{\code{\link{apply}} for the function which this is based on}
\examples{a <- array(1:27, c(2,3,4))
all.equal(a, iapply(a, 1, force))
all.equal(a, iapply(a, 2, force))
all.equal(a, iapply(a, 3, force))
all.equal(a, iapply(a, 1:2, force))
all.equal(aperm(a, c(2,1,3)), iapply(a, 2, force, REORDER=FALSE))
all.equal(aperm(a, c(3,1,2)), iapply(a, 3, force, REORDER=FALSE))

iapply(a, 1, min)
iapply(a, 1, min, DROP=TRUE)
iapply(a, 2, min)
iapply(a, 2, min, DROP=TRUE)
iapply(a, 3, min)
iapply(a, 3, min, DROP=TRUE)
iapply(a, 1, range)
iapply(a, 2, range)
iapply(a, 3, range)

mina <- iapply(a, 1, min)
sweep(a, 1, mina)
mina <- iapply(a, c(1,3), min)
sweep(a, c(1,3), mina)}
\keyword{manip}
