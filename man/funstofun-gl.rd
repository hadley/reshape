\name{funstofun}
\alias{funstofun}
\title{Aggregate multiple functions into a single function}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Combine multiple functions to a single function returning a named vector of outputs
}
\usage{funstofun(...)}
\arguments{
\item{...}{functions to combine}
}

\details{Each function should produce a single number as output}

\examples{funstofun(min, max)(1:10)
funstofun(length, mean, var)(rnorm(100))}
\keyword{manip}
