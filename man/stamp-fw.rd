\name{stamp}
\alias{stamp}
\title{Stamp}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Stamp is like reshape but the "stamping" function is passed the entire data frame, instead of just a few variables.
}
\usage{stamp(data, formula = . ~ ., fun.aggregate, ..., margins=NULL, subset=TRUE, add.missing=FALSE)}
\arguments{
\item{data}{data.frame (no molten)}
\item{formula}{formula that describes arrangement of result, columns ~ rows, see \code{\link{reshape}} for more information}
\item{fun.aggregate}{aggregation function to use, should take a data frame as the first argument}
\item{...}{arguments passed to the aggregation function}
\item{margins}{margins to compute (character vector, or \code{TRUE} for all margins), can contain \code{grand_row} or \code{grand_col} to inclue grand row or column margins respectively.}
\item{subset}{logical vector by which to subset the data frame, evaluated in the context of the data frame so you can}
\item{add.missing}{}
}

\details{It is very similar to the \code{\link{by}} function except in the form
of the output which is arranged using the formula as in \code{\link{reshape}}

Note that it's very easy to create objects that R can't print with this
function.  You will probably want to save the results to a variable and
then use extract the results.  See the examples.}

\examples{french_fries$time <- as.numeric(as.character(french_fries$time))
stamp(french_fries, subject ~ ., function(df) coef(lm(painty ~ time, df))[2])
stamp(french_fries, subject ~ treatment, function(df) coef(lm(painty ~ time, df))[2])
models <- stamp(french_fries, subject ~ ., function(df) lm(painty ~ time, df))
dim(models)
anova(models[[3,1]])}
\keyword{manip}
