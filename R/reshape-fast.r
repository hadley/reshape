castd <- function(...) {
  cm <- casta(...)
  if (dims(cm) > 2) return(cm)
  as.data.frame(cm)
}

# a + b ~ c       
# log(a + b) ~ c  
#   - only really differ in labels, but
# round(a) ~ .
# log(a) ~ .
# differ profoundly
# 
# cast is just a special case of aaply (or adply as the case may be)
# it's just the labelling that's special
# 
# to create array need to compute interactions for each dimension
# and then over interaction + ordering
# 
# if duplicates in those values, need to perform aggregation
# if no duplicated, still need to process with fun.aggregate
# 
# need to refactor to make paths of flow more obvious
# (and needs to be fast! - i.e. only take slow paths if absolutely 
# necessary)
#
# paths determined by:
#   * aggregate: more rows than ids, or !is.null(fun.aggregate)
#   * compute margins
#   * lack of balance  (fill with fun.aggregate(vector()) or NA if NULL)
#   * all combinations shown

casta <- function(data, formula = ... ~ variable, fun.aggregate=NULL, ..., drop = TRUE, margins = NULL) {
  exprs <- cast_parse_formula(deparse(formula), names(data))$m
  exprs <- Filter(function(x) length(x) > 0, exprs)
  vars <- unlist(get_vars(exprs))
  vars.clean <- clean.vars(vars)
  
  # -> need to create evaluated data.frame and then operate on 
  # that from them on - create names with make.names?
  
  # Add margins if needed
  if (!is.null(margins)) {
    if (isTRUE(margins)) margins <- c(unlist(vars.clean), "grand_row", "grand_col")
    data <- add.margins(data, unlist(vars.clean), margin.vars(vars.clean, margins))
  }
  
  # -> Compute indices and calculate dimensionality
  cols <- ldply(exprs, eval, data)
  names(cols) <- make.names(laply(exprs, deparse))  
  
  pos <- llply(seq_along(cols), function(i) ninteraction(cols[, i, drop=FALSE], drop=drop))

  # Calculate dimensionality
  dims <- laply(pos, "attr", "n")
  n <- prod(dims)

  overall <- ninteraction(pos)
  val <- data$value
  
  if (length(unique(overall)) > n) {
    # -> this bit needs to be separated out into own function
    # combine? aggregate?
    
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
  
  # -> labelling needs to be own function too
  
  # Need to do something different when drop = T
  dimnames <- lapply(seq_along(vars), function(i) {
    cols <- vars[[i]]
    if (is.null(cols)) return(data.frame(value = "(all)"))
    rows <- !duplicated(pos[[i]])
    data[rows, cols, drop=FALSE]
  })
  
  cast_matrix(results, dimnames)
}


# Clean variables.
# Clean variable list for reshaping.
#
# @arguments vector of variable names
# @value Vector of "real" variable names (excluding result\_variable etc.)
# @keyword internal
clean.vars <- function(vars) {vars[vars != "result_variable"]}
