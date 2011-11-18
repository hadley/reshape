\name{melt.default}
\alias{melt.default}
\title{Melt a vector.
For vectors, makes a column of a data frame}
\usage{
  \method{melt}{default} (data, ..., na.rm = FALSE,
    value.name = "value")
}
\arguments{
  \item{data}{vector to melt}

  \item{na.rm}{Should NA values be removed from the data
  set? This will convert explicit missings to implicit
  missings.}

  \item{...}{further arguments passed to or from other
  methods.}

  \item{value.name}{name of variable used to store values}
}
\description{
  Melt a vector. For vectors, makes a column of a data
  frame
}
\keyword{manip}

