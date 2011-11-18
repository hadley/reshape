\name{recast}
\alias{recast}
\title{Recast: melt and cast in a single step}
\usage{
  recast(data, formula, ..., id.var, measure.var)
}
\arguments{
  \item{data}{data set to melt}

  \item{formula}{casting formula, see \link{cast} for
  specifics}

  \item{...}{other arguments passed to \link{cast}}

  \item{id.var}{identifying variables. If blank, will use
  all non measure.var variables}

  \item{measure.var}{measured variables. If blank, will use
  all non id.var variables}
}
\description{
  This conveniently wraps melting and casting a data frame
  into a single step.
}
\examples{
recast(french_fries, time ~ variable, id.var = 1:4)
}
\seealso{
  \url{http://had.co.nz/reshape/}
}
\keyword{manip}

