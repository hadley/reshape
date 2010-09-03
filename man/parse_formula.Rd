\name{parse_formula}
\alias{parse_formula}
\title{Parse casting formulae.}
\usage{parse_formula(formula="...  ~ variable", varnames)}

\description{
  Parse casting formulae.
}

\details{
  There are a two ways to specify a casting formula: either as a
  string, or a list of quoted variables. This function converts the
  former to the latter.

  Casting formulas separate dimensions with \code{~} and variables
  within a dimension with \code{+} or \code{*}. \code{.} can be used as
  a placeholder, and \code{...} represents all other variables not
  otherwise used.
}
\arguments{
  \item{formula}{formula to parse}
  \item{varnames}{names of all variables in data}
}
\examples{parse_formula("a + ...", letters[1:6])
parse_formula("a ~ b + d")
parse_formula("a + b ~ c ~ .")}
