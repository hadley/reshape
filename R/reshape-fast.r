ninteraction <- function(vars, drop = FALSE) {  
  if (length(vars) == 0) {
    res <- structure(rep.int(1L, nrow(vars)), n = 1L)
    return(res)
  }
  
  if (length(vars) == 1) {
    f <- as.factor(vars[[1]])
    res <- structure(as.integer(f), n = nunique(f))
    return(res)
  }
  
  # Convert to factors, if necessary
  not_factor <- !laply(vars, is.factor)
  vars[not_factor] <- llply(vars[not_factor], factor, exclude=NULL)
  
  # Calculate dimensions

  ndistinct <- laply(vars, nunique)
  n <- prod(ndistinct)

  p <- length(vars)
  combs <- c(1, cumprod(ndistinct[-p]))
  
  mat <- do.call("cbind", lapply(vars, as.integer))
  res <- c((mat - 1L) %*% combs + 1L)
  
  # vdf <- data.frame(vars)
  # names(vdf) <- paste("X", 1:ncol(vdf), sep="")
  # vdf$i <- res
  # browser()
  
  if (drop) {
    f <- factor(res) 
    n <- nunique(f)
    res <- as.integer(f)
  }
  
  attr(res, "n") <- n
  res
}

castd <- function(...) {
  cm <- casta(...)
  if (dims(cm) > 2) return(cm)
  as.data.frame(cm)
}

casta <- function(data, formula = ... ~ variable, fun.aggregate=NULL, ..., drop = TRUE, margins = NULL) {
  exprs <- cast_parse_formula(deparse(formula), names(data))$m
  exprs <- Filter(function(x) length(x) > 0, exprs)
  vars <- unlist(get_vars(list(exprs)))
	vars.clean <- clean.vars(vars)
	
	# Add margins if needed
	if (!is.null(margins)) {
  	if (isTRUE(margins)) margins <- c(unlist(vars.clean), "grand_row", "grand_col")
  	data <- add.margins(data, unlist(vars.clean), margin.vars(vars.clean, margins))
	}
  cols <- ldply(exprs, eval, data)
  names(cols) <- make.names(laply(exprs, deparse))
  
  pos <- llply(seq_along(cols), function(i) ninteraction(cols[, i, drop=FALSE], drop=drop))

  # Calculate dimensionality
	dims <- laply(pos, "attr", "n")
  n <- prod(dims)

  overall <- ninteraction(pos)
  val <- data$value
  
  if (length(overall) > n) {
    # Aggregation 
    if (is.null(fun.aggregate)) {
			message("Aggregation requires fun.aggregate: length used as default")
			fun.aggregate <- length
		}
    fun.index <- function(x) fun.aggregate(val[x], ...)
    
    pieces <- split(seq_along(overall), factor(overall, levels=1:n))
    results <- do.call("rbind", lapply(pieces, fun.index))
  } else {
    # Fill in missing combinations, if necessary
    overall <- order(overall)
    if (length(overall) < n) overall <- match(1:n, overall, nomatch = NA)
    results <- val[overall]    
  }
  
  dim(results) <- dims
  
  # Need to do something different when drop = T
  dimnames <- lapply(seq_along(vars), function(i) {
    cols <- vars[[i]]
    if (is.null(cols)) return(data.frame(value = "(all)"))
    rows <- !duplicated(pos[[i]])
    data[rows, cols, drop=FALSE]
  })
  
  cast_matrix(results, dimnames)
}

# az <- read.csv("output/az.csv")

add.margins <- function(data, vars, margins) {
	if (length(margins) == 0) return(data)
	
	# Ensure all variables are factors, and have level (all)
	data[vars] <- lapply(data[vars], as.factor)
	data[vars] <- lapply(data[vars], function(x) {
	  levels(x) <- c(levels(x), "(all)"); x
	})

	margin <- function(v) {
		over <- setdiff(unlist(vars), v)
		data[, over] <- rep(factor("(all)"), length(over))
		data
	}
	out <- do.call("rbind", lapply(margins, margin))
	rbind(data, out)

}

test_cast <- function(e, a) {
  stopifnot(all.equal(dim(e), dim(a)))
}

# test_cast(casta(test2, A + B ~ .), 1:20)

# Tests need to check:
#   * margins
#   * drop = F and T
#   * pure casting
#   * arrays and data.frames
#   * variable names and order 
