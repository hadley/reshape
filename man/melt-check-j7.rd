\name{melt_check}
\alias{melt_check}
\title{Melt check.}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Check that input variables to melt are appropriate.
}
\usage{melt_check(data, id.vars, measure.vars)}
\arguments{
\item{data}{data frame}
\item{id.vars}{Vector of identifying variable names or indexes}
\item{measure.vars}{Vector of Measured variable names or indexes}
}
\value{
  \item{id}{list id variable names}
  \item{measure}{list of measured variable names}
}
\details{If id.vars or measure.vars are missing, \code{melt_check} will do its
best to impute them.If you only
supply one of id.vars and measure.vars, melt will assume the remainder of
the variables in the data set belong to the other. If you supply neither,
melt will assume character and factor variables are id variables,
and all other are measured.}

\examples{}
\keyword{internal}
