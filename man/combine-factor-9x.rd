\name{combine_factor}
\alias{combine_factor}
\title{Combine factor levels}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Convenience function to make it easy to combine multiple levels
}
\usage{combine_factor(fac, variable=levels(fac), other.label="Other")}
\arguments{
\item{fac}{factor variable}
\item{variable}{either a vector of   .  See examples for more details.}
\item{other.label}{label for other level}
}

\details{}

\examples{df <- data.frame(a = LETTERS[sample(5, 15, replace=TRUE)], y = rnorm(15))	
combine_factor(df$a, c(1,2,2,1,2))
combine_factor(df$a, c(1:4, 1))
(f <- reorder_factor(df$a, tapply(df$y, df$a, mean)))
percent <- tapply(abs(df$y), df$a, sum)
combine_factor(f, c(order(percent)[1:3]))}
\keyword{manip}
