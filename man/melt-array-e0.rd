\name{melt.array}
\alias{melt.array}
\alias{melt.matrix}
\alias{melt.table}
\title{Melt an array}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
This function melts a high-dimensional array into a form that you can use \code{\link{cast}} with.
}
\usage{melt.array(data, varnames = names(dimnames(data)), ...)}
\arguments{
\item{data}{array to melt}
\item{varnames}{variable names to use in molten data.frame}
\item{...}{}
}

\details{}

\examples{a <- array(1:24, c(2,3,4))
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a)[1] <- list(NULL)
melt(a)}
\keyword{manip}
