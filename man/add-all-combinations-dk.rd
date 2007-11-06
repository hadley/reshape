\name{add.all.combinations}
\alias{add.all.combinations}
\title{Add all combinations}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Add all combinations of the given rows and columns to the data frames.
}
\usage{add.all.combinations(data, vars = list(NULL), fill=NA)}
\arguments{
\item{data}{data.frame}
\item{vars}{variables (list of character vectors)}
\item{fill}{value to fill structural missings with}
}

\details{This function is used to ensure that we have a matrix of the appropriate
dimensionaliy with no missing cells.}

\examples{rdunif <- 
function(n=20, min=0, max=10) floor(runif(n,min, max))
df <- data.frame(a = rdunif(), b = rdunif(),c = rdunif(), result=1:20)
add.all.combinations(df)
add.all.combinations(df, list("a", "b"))
add.all.combinations(df, list("a", "b"), fill=0)
add.all.combinations(df, list(c("a", "b")))
add.all.combinations(df, list("a", "b", "c"))
add.all.combinations(df, list(c("a", "b"), "c"))
add.all.combinations(df, list(c("a", "b", "c")))}
\keyword{internal}
