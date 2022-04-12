\name{margin.vars}
\alias{margin.vars}
\title{Margin variables}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Works out list of variables to margin over to get desired margins.
}
\usage{margin.vars(vars = list(NULL, NULL), margins = NULL)}
\arguments{
\item{vars}{list of column and row variables}
\item{margins}{vector of variable names to margin over}
}

\details{Variables that can't be margined over are dropped silently.}

\keyword{internal}
