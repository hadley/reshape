\name{expand}
\alias{expand}
\title{Expand}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Expand out condensed data frame.
}
\usage{expand(data)}
\arguments{
\item{data}{condensed data frame}
}

\details{If aggregating function supplied to condense returns multiple values, this
function "melts" it again, creating a new column called result\_variable.

If the aggregating funtion is a named vector, then those names will be used,
otherwise will be number X1, X2, ..., Xn etc.}

\keyword{manip}
\keyword{internal}
