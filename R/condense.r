# Condense
# Condense a data frame.
#
# Works very much like by, but keeps data in original data frame format.
# Results column is a list, so that each cell may contain an object or a vector etc.
# Assumes data is in molten format. Aggregating function must return the
# same number of arguments for all input.
#
# @arguments data frame
# @arguments variables to condense over
# @arguments aggregating function, may multiple values
# @arguments further arguments passed on to aggregating function
# @keyword manip
# @keyword internal
condense <- function(data, variables, fun, ...) {
  if (length(variables) == 0 ) {
    df <- data.frame(result = 0)
    df$result <- list(fun(data$value, ...))
    return(df)
  }

  sorted <- sort_df(data, variables)[,c(variables, "value"), drop=FALSE]
  duplicates <- duplicated(sorted[,variables, drop=FALSE])
  index <- cumsum(!duplicates) 
  
  results <- tapply(sorted$value, index, fun, ..., simplify = FALSE)

  cols <- sorted[!duplicates,variables, drop=FALSE]
  cols$result <- array(results)
  cols
}

# Expand
# Expand out condensed data frame.
#
# If aggregating function supplied to condense returns multiple values, this
# function "melts" it again, creating a new column called result\_variable.
#
# If the aggregating funtion is a named vector, then those names will be used,
# otherwise will be number X1, X2, ..., Xn etc.
#
# @arguments condensed data frame
# @keyword manip
# @keyword internal
expand <- function(data) {
  lengths <- unique(sapply(data$result, length))
  if (lengths == 1) return(data)

  first <- data[1, "result"][[1]]
  exp <- lapply(1:length(first), function(x) as.vector(unlist(lapply(data$result, "[", x))))
  names(exp) <- if (is.null(names(first))) make.names(1:length(first)) else make.names(names(first))

  x <- melt(data.frame(data[, seq_len(ncol(data) -1), drop=FALSE], exp), m=names(exp),variable_name="result_variable")
  colnames(x)[match("value", colnames(x), FALSE)] <- "result"
  x
}


# Clean variables.
# Clean variable list for reshaping.
#
# @arguments vector of variable names
# @value Vector of "real" variable names (excluding result\_variable etc.)
# @keyword internal
clean.vars <- function(vars) {vars[vars != "result_variable"]}

