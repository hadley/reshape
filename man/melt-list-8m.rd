\name{melt.list}
\alias{melt.list}
\title{Melt a list}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Melting a list recursively melts each component of the list and joins the results together
}
\usage{melt.list(data, ..., level=1)}
\arguments{
\item{data}{}
\item{...}{other arguments passed down}
\item{level}{}
}


\examples{a <- as.list(1:4)
melt(a)
names(a) <- letters[1:4]
melt(a)
attr(a, "varname") <- "ID"
melt(a)
a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
melt(a)
a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
melt(a)
melt(list(1:5, matrix(1:4, ncol=2)))
melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))}
\keyword{internal}
