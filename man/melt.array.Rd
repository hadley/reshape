\name{melt.array}
\alias{melt.array}
\title{Melt an array.}
\usage{\method{melt}{array} (data, varnames=names(dimnames(data)),
    ..., na.rm=FALSE, value.name="value")}

\description{
  Melt an array.
}

\details{
  This code is conceptually similar to
  \code{\link{as.data.frame.table}}
}
\keyword{manip}
\arguments{
  \item{data}{array to melt}
  \item{varnames}{variable names to use in molten data.frame}
  \item{...}{further arguments passed to or from other methods.}
  \item{value.name}{name of variable used to store values}
  \item{na.rm}{Should NA values be removed from the data set? This will 
convert explicit missings to implicit missings.}
}
\examples{a <- array(c(1:23, NA), c(2,3,4))
melt(a)
melt(a, na.rm = TRUE)
melt(a, varnames=c("X","Y","Z"))
dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
melt(a)
melt(a, varnames=c("X","Y","Z"))
dimnames(a)[1] <- list(NULL)
melt(a)}
