\name{melt.data.frame}
\alias{melt.data.frame}
\title{Melt a data frame}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Melt a data frame into form suitable for easy casting.
}
\usage{melt.data.frame(data, id.vars, measure.vars, variable_name = "variable", na.rm = !preserve.na, preserve.na = TRUE, ...)}
\arguments{
\item{data}{Data set to melt}
\item{id.vars}{Id variables. If blank, will use all non measure.vars variables.  Can be integer (variable position) or string (variable name)}
\item{measure.vars}{Measured variables. If blank, will use all non id.vars variables. Can be integer (variable position) or string (variable name)}
\item{variable_name}{Name of the variable that will store the names of the original variables}
\item{na.rm}{Should NA values be removed from the data set?}
\item{preserve.na}{Old argument name, now deprecated}
\item{...}{}
}
\value{molten data}
\details{You need to tell melt which of your variables are id variables, and which
are measured variables. If you only supply one of \code{id.vars} and
\code{measure.vars}, melt will assume the remainder of the variables in the
data set belong to the other. If you supply neither, melt will assume
factor and character variables are id variables, and all others are
measured.}
\seealso{\url{http://had.co.nz/reshape/}}
\examples{head(melt(tips))
names(airquality) <- tolower(names(airquality))
melt(airquality, id=c("month", "day"))
names(ChickWeight) <- tolower(names(ChickWeight))
melt(ChickWeight, id=2:4)}
\keyword{manip}
