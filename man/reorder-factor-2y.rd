\name{reorder_factor}
\alias{reorder_factor}
\title{Reorder factor levels}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Convenience method for reordering the levels of a factor
}
\usage{reorder_factor(fac, variable=levels(fac), decreasing=FALSE)}
\arguments{
\item{fac}{factor variable}
\item{variable}{new order}
\item{decreasing}{whether should be sorted descreasing}
}

\details{}

\examples{df <- data.frame(a = LETTERS[sample(5, 15, replace=TRUE)], y = rnorm(15))	
(f <- reorder_factor(df$a, tapply(df$y, df$a, mean)))
(f <- reorder_factor(f))
reorder_factor(f, c(4,2,3,1,5), dec=TRUE)}
\keyword{manip}
