\name{guess_value}
\alias{guess_value}
\title{Guess value}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Guess name of value column
}
\usage{guess_value(df)}
\arguments{
\item{df}{Data frame to guess value column from}
}

\details{Strategy:
\enumerate{
\item Is value or (all) column present? If so, use that
\item Otherwise, guess that last column is the value column
}}

\examples{}
\keyword{internal}
