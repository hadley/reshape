simplify <- function(x) {
  if (x == as.name("...")) return(list(bquote(-0)))
  if (x == as.name(".")) return(list())
  if (length(x) < 3) return(list(x))
  op <- x[[1]]; a <- x[[2]]; b <- x[[3]]
  
  if (op == as.name("+") || op == as.name("*")) {
    c(simplify(a), simplify(b))
  } else if (op == as.name("-")) {
    c(simplify(a), bquote(-.(x), list(x=simplify(b))))
  } else {
    x
  }
}

parse_expression <- function(f) {
  if (is.formula(f)) f <- deparse(f)
  parts <- strsplit(f, "\\|")[[1]]
	
	list(
	  m = structure(lapply(as.quoted(parts[1]), simplify), class="quoted"),
	  l = if(length(parts) > 1) structure(lapply(as.quoted(parts[2]), simplify), class = "quoted")
	)
}

get_vars <- function(x) {
  if (is.null(x)) return() 
  lapply(x, function(x) lapply(x, function(x) all.vars(asOneSidedFormula(x))))
}

is.negated <- function(x) sapply(x, is.negated.single)
is.negated.single <- function(x) is.language(x) && length(x) == 2 && x[[1]] == as.name("-")