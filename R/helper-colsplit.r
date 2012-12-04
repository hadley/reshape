#' Split a vector into multiple columns
#'
#' Useful for splitting variable names that a combination of multiple
#' variables. Uses \code{\link{type.convert}} to convert each column to
#' correct type, but will not convert character to factor.
#'
#' @param string character vector or factor to split up
#' @param pattern regular expression to split on
#' @param names names for output columns
#' @keywords manip
#' @export
#' @examples
#' x <- c("a_1", "a_2", "b_2", "c_3")
#' vars <- colsplit(x, "_", c("trt", "time"))
#' vars
#' str(vars)
colsplit <- function(string, pattern, names) {
  vars <- str_split_fixed(string, pattern, n = length(names))

  df <- data.frame(alply(vars, 2, type.convert, as.is = TRUE),
    stringsAsFactors = FALSE)
  names(df) <- names

  df
}

