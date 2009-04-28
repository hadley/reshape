\name{cast_parse_formula}
\alias{cast_parse_formula}
\title{Cast parse formula}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Parse formula for casting
}
\usage{cast_parse_formula(formula = "...  ~ variable", varnames)}
\arguments{
\item{formula}{}
\item{varnames}{}
}
\value{
  \item{row}{character vector of row names}
  \item{col}{character vector of column names}
  \item{aggregate}{boolean whether aggregation will occur}
}
\details{@value row character vector of row names
@value col character vector of column names
@value aggregate boolean whether aggregation will occur
@keyword internal}

\examples{cast_parse_formula("a + ...", letters[1:6])
cast_parse_formula("a | ...", letters[1:6])
cast_parse_formula("a + b ~ c ~ . | ...", letters[1:6])}
\keyword{internal}
