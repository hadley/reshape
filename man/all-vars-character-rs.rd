\name{all.vars.character}
\alias{all.vars.character}
\title{Get all variables}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
All variables in character string of formula.
}
\usage{all.vars.character(formula, blank.char = ".")}
\arguments{
\item{formula}{}
\item{blank.char}{}
}

\details{Removes .}

\examples{all.vars.character("a + b")
all.vars.character("a + b | c")
all.vars.character("a + b")
all.vars.character(". ~ a + b")
all.vars.character("a ~ b | c + d + e")}
\keyword{internal}
