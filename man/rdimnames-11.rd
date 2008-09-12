\name{rdimnames}
\alias{rdimnames}
\alias{rdimnames<-}
\alias{rcolnames}
\alias{rcolnames<-}
\alias{rrownames}
\alias{rrownames<-}
\title{Dimension names}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
These methods provide easy access to the special dimension names
}
\usage{rdimnames(x)}
\arguments{
\item{x}{}
}

\details{Reshape stores dimension names in a slightly different format to
base R, to allow for (e.g.) multiple levels of column header.  These
accessor functions allow you to get and set them.}

\examples{}
\keyword{internal}
