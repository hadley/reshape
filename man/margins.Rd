\name{margins}
\alias{margins}
\title{Figure out margining variables.}
\usage{margins(vars, margins)}

\description{
  Figure out margining variables.
}

\details{
  Given the variables that form the rows and columns, and a
  set of desired margins, works out which ones are
  possible. Variables that can't be margined over are
  dropped silently.
}
\keyword{manip}
\keyword{internal}
\value{list of margining combinations, or \code{NULL} if none. These are
the combinations of variables that should have their values set to 
\code{(all)}}
\arguments{
  \item{vars}{a list of character vectors giving the variables in each
dimension}
  \item{margins}{a character vector of variable names to compute margins for.
\code{TRUE} will compute all possible margins.}
}
