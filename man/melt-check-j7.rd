\name{melt_check}
\alias{melt_check}
\title{Melt check.}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Check that input variables to melt are appropriate.
}
\usage{melt_check(data, id.var, measure.var)}
\arguments{
\item{data}{data frame}
\item{id.var}{Vector of identifying variable names or indexes}
\item{measure.var}{Vector of Measured variable names or indexes}
}
\value{
 \item{id list id variable names}
 \item{measure list of measured variable names}
}
\details{If id.var or measure.var are missing, \code{melt_check }will do its
best to impute them.If you only
supply one of id.var and measure.var, melt will assume the remainder of
the variables in the data set belong to the other.	If you supply neither,
melt will assume integer and factor	 variables are id variables,
and all other are measured.}

\examples{}
\keyword{internal}
