\name{reshape1}
\alias{reshape1}
\title{Casting workhorse.}
\author{Hadley Wickham <h.wickham@gmail.com>}

\description{
Takes data frame and variable list and casts data.
}
\usage{reshape1(data, vars = list(NULL, NULL), fun.aggregate=NULL, margins, df=FALSE, fill=NA, add.missing=FALSE, ...)}
\arguments{
\item{data}{data frame}
\item{vars}{variables to appear in columns}
\item{fun.aggregate}{variables to appear in rows}
\item{margins}{aggregation function}
\item{df}{should the aggregating function be supplied with the entire data frame, or just the relevant entries from the values column}
\item{fill}{vector of variable names (can include "grand\_col" and "grand\_row") to compute margins for, or TRUE to computer all margins}
\item{add.missing}{value with which to fill in structural missings}
\item{...}{further arguments are passed to aggregating function}
}

\details{}
\seealso{\code{\link{cast}}}
\examples{
ffm <- melt(french_fries, id=1:4, na.rm = TRUE)
# Casting lists ----------------------------
cast(ffm, treatment ~ rep | variable, mean)
cast(ffm, treatment ~ rep | subject, mean)
cast(ffm, treatment ~ rep | time, mean)
cast(ffm, treatment ~ rep | time + variable, mean)
names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, id=c("month", "day"), preserve=FALSE)
#Basic call
reshape1(aqm, list("month", NULL), mean)
reshape1(aqm, list("month", "variable"), mean)
reshape1(aqm, list("day", "month"), mean)

#Explore margins  ----------------------------
reshape1(aqm, list("month", NULL), mean, "month")
reshape1(aqm, list("month", NULL) , mean, "grand_col")
reshape1(aqm, list("month", NULL) , mean, "grand_row")

reshape1(aqm, list(c("month", "day"), NULL), mean, "month")
reshape1(aqm, list(c("month"), "variable"), mean, "month")
reshape1(aqm, list(c("variable"), "month"), mean, "month")
reshape1(aqm, list(c("month"), "variable"), mean, c("month","variable"))

reshape1(aqm, list(c("month"), "variable"), mean, c("grand_row"))
reshape1(aqm, list(c("month"), "variable"), mean, c("grand_col"))
reshape1(aqm, list(c("month"), "variable"), mean, c("grand_row","grand_col"))

reshape1(aqm, list(c("variable","day"),"month"), mean,c("variable"))
reshape1(aqm, list(c("variable","day"),"month"), mean,c("variable","grand_row"))
reshape1(aqm, list(c("month","day"), "variable"), mean, "month") 

# Multiple fnction returns  ----------------------------
reshape1(aqm, list(c("month", "result_variable"), NULL), range) 
reshape1(aqm, list(c("month"),"result_variable") , range) 
reshape1(aqm, list(c("result_variable", "month"), NULL), range) 

reshape1(aqm, list(c("month", "result_variable"), "variable"), range, "month")
reshape1(aqm, list(c("month", "result_variable"), "variable"), range, "variable")
reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("variable","month"))
reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("grand_col"))
reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("grand_row"))

reshape1(aqm, list(c("month"), c("variable")), function(x) diff(range(x))) }
\keyword{internal}
