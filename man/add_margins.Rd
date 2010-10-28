\name{add_margins}
\alias{add_margins}
\title{Add margins to a data frame.}
\usage{add_margins(df, vars, margins=TRUE)}

\description{
  Add margins to a data frame.
}

\details{
  Rownames are silently stripped. All margining variables
  will be converted to factors.
}
\arguments{
  \item{df}{input data frame}
  \item{vars}{a list of character vectors giving the variables in each
dimension}
  \item{margins}{a character vector of variable names to compute margins for.
\code{TRUE} will compute all possible margins.}
}
