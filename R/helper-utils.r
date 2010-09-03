# Split a vector into multiple columns
# This function can be used to split up a column that has been pasted together.
# 
# @arguments character vector or factor to split up
# @arguments regular expression to split on
# @arguments names for output columns
# @keyword manip
# @alias colsplit.factor
# @alias colsplit.character
colsplit <- function(x, split="", names) UseMethod("colsplit", x)
colsplit.factor <- function(x, split="", names) colsplit(as.character(x), split, names)
colsplit.character <- function(x, split="", names) {
  vars <- as.data.frame(do.call(rbind, strsplit(x, split)))
  names(vars) <- names
  as.data.frame(lapply(vars, function(x) type.convert(as.character(x))))
}

