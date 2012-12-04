#' Parse casting formulae.
#'
#' There are a two ways to specify a casting formula: either as a string, or
#' a list of quoted variables. This function converts the former to the
#' latter.
#'
#' Casting formulas separate dimensions with \code{~} and variables within
#' a dimension with \code{+} or \code{*}. \code{.} can be used as a
#' placeholder, and \code{...} represents all other variables not otherwise
#' used.
#'
#' @param formula formula to parse
#' @param varnames names of all variables in data
#' @param value.var name of variable containing values
#' @examples
#' reshape2:::parse_formula("a + ...", letters[1:6])
#' reshape2:::parse_formula("a ~ b + d")
#' reshape2:::parse_formula("a + b ~ c ~ .")
parse_formula <- function(formula = "...  ~ variable", varnames, value.var = "value") {
  remove.placeholder <- function(x) x[x != "."]
  replace.remainder <- function(x) {
    if (any(x == "...")) c(x[x != "..."], remainder) else x
  }

  if (is.formula(formula)) {
    formula <- str_c(deparse(formula, 500), collapse = "")
  }

  if (is.character(formula)) {
    dims <- str_split(formula, fixed("~"))[[1]]
    formula <- lapply(str_split(dims, "[+*]"), str_trim)

    formula <- lapply(formula, remove.placeholder)

    all_vars <- unlist(formula)
    if (any(all_vars == "...")) {
      remainder <- setdiff(varnames, c(all_vars, value.var))
      formula <- lapply(formula, replace.remainder)
    }
  }

  if (!is.list(formula)) {
    stop("Don't know how to parse", formula, call. = FALSE)
  }

  lapply(formula, as.quoted)
}
