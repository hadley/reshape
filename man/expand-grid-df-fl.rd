\name{expand.grid.df}
\alias{expand.grid.df}
\title{Expand grid}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Expand grid of data frames
}
\usage{expand.grid.df(..., unique=TRUE)}
\arguments{
\item{...}{list of data frames (first varies fastest)}
\item{unique}{only use unique rows?}
}

\details{Creates new data frame containing all combination of rows from
data.frames in \code{...}}

\examples{expand.grid.df(data.frame(a=1,b=1:2))
expand.grid.df(data.frame(a=1,b=1:2), data.frame())
expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2))
expand.grid.df(data.frame(a=1,b=1:2), data.frame(c=1:2, d=1:2), data.frame(e=c("a","b")))}
\keyword{manip}
