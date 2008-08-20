# Cast parse formula
# Parse formula for casting
#
# @value row character vector of row names
# @value col character vector of column names
# @value aggregate boolean whether aggregation will occur
# @keyword internal
#
#X cast_parse_formula("a + ...", letters[1:6])
#X cast_parse_formula("a | ...", letters[1:6])
#X cast_parse_formula("a + b ~ c ~ . | ...", letters[1:6])
cast_parse_formula <- function(formula = "... ~ variable", varnames) {
  # check_formula(formula, varnames)
  
  parts <- parse_expression(formula)

  vars <- lapply(parts, get_vars)    
  remainder <- lapply(setdiff(varnames, c(unlist(vars), "value")), as.name)
  
  replace.remainder <- function(x) {
    rem <- is.negated(x)
    if (all(!rem)) return(x)
    
    c(x[seq_along(x) < which(rem)], remainder, x[seq_along(x) > which(rem)])
  }
  
  list(
    m = lapply(parts$m, replace.remainder),
    l = rev(replace.remainder(parts$l))
  )
}


# Check formula
# Checks that formula is a valid reshaping formula.
#
# \enumerate{
#   \item variable names not found in molten data
#   \item same variable used in multiple places
# }
# @arguments formula to check
# @arguments vector of variable names
# @keyword internal
check_formula <- function(formula, varnames) {
  vars <- unlist(all.vars.character(formula))
  unknown <- setdiff(vars, c(".", "...","result_variable",varnames))
  
  if (length(unknown) > 0) stop("Casting formula contains variables not found in molten data: ", paste(unknown, collapse=", "), call. = FALSE)
  vars <- vars[vars != "."]
  if (length(unique(vars)) < length(vars)) stop("Variable names repeated", call. = FALSE)
}
