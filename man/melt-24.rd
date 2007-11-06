\name{melt}
\alias{melt}
\title{Melt}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Melt an object into a form suitable for easy casting.
}
\usage{melt(data, ...)}
\arguments{
\item{data}{Data set to melt}
\item{...}{Other arguments passed to the specific melt method}
}

\details{This the generic melt function. See the following functions
for specific details for different data structures:

\itemize{
\item \code{\link{melt.data.frame}} for data.frames
\item \code{\link{melt.array}} for arrays, matrices and tables
\item \code{\link{melt.list}} for lists
}}

\examples{}
\keyword{manip}
