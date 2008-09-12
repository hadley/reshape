\name{namerows}
\alias{namerows}
\title{Name rows}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Add variable to data frame containing rownames
}
\usage{namerows(df, col.name = "id")}
\arguments{
\item{df}{data frame}
\item{col.name}{name of new column containing rownames}
}

\details{This is useful when the thing that you want to melt by is the rownames
of the data frame, not an explicit variable}

\examples{}
\keyword{manip}
