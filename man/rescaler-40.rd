\name{rescaler}
\alias{rescaler}
\title{Rescaler}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Convenient methods for rescaling data
}
\usage{rescaler(x, type="sd", ...)}
\arguments{
\item{x}{object to rescale}
\item{type}{type of rescaling to use (see description for details)}
\item{...}{other options (only pasesed to \code{\link{rank}})}
}

\details{Provides methods for vectors, matrices and data.frames

Currently, five rescaling options are implemented:

\itemize{
\item \code{I}: do nothing
\item \code{range}: scale to [0, 1]
\item \code{rank}: convert values to ranks
\item \code{robust}: robust version of \code{sd}, substract median and divide by median absolute deviation
\item \code{sd}: subtract mean and divide by standard deviation
}}
\seealso{\code{\link{rescaler.default}}}
\keyword{manip}
