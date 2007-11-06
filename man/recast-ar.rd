\name{recast}
\alias{recast}
\title{Recast}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
\link{melt} and \link{cast} data in a single step
}
\usage{recast(data, formula, ..., id.var, measure.var)}
\arguments{
\item{data}{Data set to melt}
\item{formula}{Casting formula, see \link{cast} for specifics}
\item{...}{Other arguments passed to \link{cast}}
\item{id.var}{Identifying variables. If blank, will use all non measure.var variables}
\item{measure.var}{Measured variables. If blank, will use all non id.var variables}
}

\details{This conveniently wraps melting and casting a data frame into
one step.}
\seealso{\url{http://had.co.nz/reshape/}}
\examples{recast(french_fries, time ~ variable, id.var=1:4)}
\keyword{manip}
