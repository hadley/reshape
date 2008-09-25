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
cast_parse_formula <- function(formula = "...  ~ variable", varnames) {
  check_formula(formula, varnames)
  
  vars <- all.vars.character(formula)
  
  remainder <- varnames[!(varnames %in% c(unlist(vars), "value"))]
  replace.remainder <- function(x) if (any(x == "..."))  c(x[x != "..."], remainder) else x
  
  list(
    m = lapply(vars$m, replace.remainder),
    l = rev(replace.remainder(vars$l))
  )
}

# Get all variables
# All variables in character string of formula.
# 
# Removes .
# 
# @keyword internal
# @returns list of variables in each part of formula 
#X all.vars.character("a + b")
#X all.vars.character("a + b | c")
#X all.vars.character("a + b")
#X all.vars.character(". ~ a + b")
#X all.vars.character("a ~ b | c + d + e")
all.vars.character <- function(formula, blank.char = ".") {
  formula <- paste(formula, collapse="")
  vars <- function(x) {
    if (is.na(x)) return(NULL)
    remove.blank(strsplit(gsub("\\s+", "", x), "[*+]")[[1]])
  }
  remove.blank <- function(x) {
    x <- x[x != blank.char]
    if(length(x) == 0) NULL else x
  }
  
  parts <- strsplit(formula, "\\|")[[1]]
  
  list(
    m = lapply(strsplit(parts[1], "~")[[1]], vars),
    l = vars(parts[2])
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
