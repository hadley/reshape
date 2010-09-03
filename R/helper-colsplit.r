#' Split a vector into multiple columns
#' 
#' Useful for splitting variable names that a combination of multiple 
#' variables.  Uses \code{\link{type.convert}} to convert each column to
#' correct type.
#' 
#' @param string character vector or factor to split up
#' @param pattern regular expression to split on
#' @param names names for output columns
#' @keywords manip
#' @examples
#' x <- c("a_1", "a_2", "b_2", "c_3")
#' vars <- colsplit(x, "_", c("trt", "time"))
#' vars
#' str(vars)
colsplit <- function(string, pattern, names) {
  vars <- as.data.frame(str_split_fixed(string, pattern, n = length(names)))
  names(vars) <- names
  as.data.frame(lapply(vars, type.convert))
}

