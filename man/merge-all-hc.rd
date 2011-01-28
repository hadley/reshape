\name{merge_all}
\alias{merge_all}
\title{Merge all}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Merge together a series of data.frames
}
\usage{merge_all(dfs, ...)}
\arguments{
\item{dfs}{list of data frames to merge}
\item{...}{other arguments passed on to merge}
}

\details{Order of data frames should be from most complete to least complete}
\seealso{\code{\link{merge_recurse}}}
\keyword{manip}
