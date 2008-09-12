\name{rename}
\alias{rename}
\title{Rename}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Rename an object
}
\usage{rename(x, replace)}
\arguments{
\item{x}{object to be renamed}
\item{replace}{named vector specifying new names}
}

\details{The rename function provide an easy way to rename the columns of a
data.frame or the items in a list.}

\examples{rename(mtcars, c(wt = "weight", cyl = "cylinders"))
a <- list(a = 1, b = 2, c = 3)
rename(a, c(b = "a", c = "b", a="c"))}
\keyword{manip}
