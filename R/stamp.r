# Stamp 
# Stamp is like reshape but the "stamping" function is passed the entire data frame, instead of just a few variables.
# 
# It is very similar to the \code{\link{by}} function except in the form
# of the output which is arranged using the formula as in \code{\link{reshape}}
# 
# Note that it's very easy to create objects that R can't print with this
# function.  You will probably want to save the results to a variable and
# then use extract the results.  See the examples.
# 
# @arguments data.frame (no molten)
# @arguments formula that describes arrangement of result, columns ~ rows, see \code{\link{reshape}} for more information
# @arguments aggregation function to use, should take a data frame as the first argument
# @arguments arguments passed to the aggregation function
# @arguments margins to compute (character vector, or \code{TRUE} for all margins), can contain \code{grand_row} or \code{grand_col} to inclue grand row or column margins respectively.
# @arguments logical vector by which to subset the data frame, evaluated in the context of the data frame so you can 
#@keyword manip 
stamp <- function(data, formula = . ~ ., fun.aggregate, ..., margins=NULL, subset=TRUE, add.missing=FALSE) {
  if (inherits(formula, "formula")) formula <- deparse(substitute(formula)) 
  cast(data, formula, fun.aggregate, ..., margins=margins, subset=subset, df=TRUE,add.missing=add.missing, value="")
}

# Condense a data frame
# Condense
# 
# @arguments data frame
# @arguments character vector of variables to condense over
# @arguments function to condense with
# @arguments arguments passed to condensing function
# @keyword manip 
condense.df <- function(data, variables, fun, ...) {
  if (length(variables) == 0 ) {
    df <- data.frame(results = 0)
    df$results <- list(fun(data, ...))
    return(df)
  }

  sorted <- sort_df(data, variables)
  duplicates <- duplicated(sorted[,variables, drop=FALSE])
  index <- cumsum(!duplicates)

  results <- by(sorted, index, fun, ...)

  cols <- sorted[!duplicates,variables, drop=FALSE]
  cols$results <- array(results)
  cols
}

# Tidy up stamped data set
# @keyword internal
tidystamp <- function(x) {
 bind <- function(i) cbind(x[i, -ncol(x),drop=FALSE], x$value[[i]])
 l <- lapply(1:nrow(x), bind)
 do.call(rbind.fill, l)
}