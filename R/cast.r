# Cast function
# Cast a molten data frame into the reshaped or aggregated form you want
#
# Along with \code{\link{melt}}  and \link{recast}, this is the only function you should ever need to use.
# Once you have melted your data, cast will arrange it into the form you desire
# based on the specification given by \code{formula}.
#
# The cast formula has the following format: \code{x_variable + x_2 ~ y_variable + y_2 ~ z_variable ~  ... | list_variable + ... }
# The order of the variables makes a difference.  The first varies slowest, and the last 
# fastest.  There are a couple of special variables: "..." represents all other variables 
# not used in the formula and "." represents no variable, so you can do \code{formula=var1 ~ .}
#
# Creating high-D arrays is simple, and allows a class of transformations that are hard
# without \code{\link{apply}} and \code{\link{sweep}} 
#
# If the combination of variables you supply does not uniquely identify one row in the 
# original data set, you will need to supply an aggregating function, \code{fun.aggregate}.
# This function should take a vector of numbers and return a summary statistic(s).  It must
# return the same number of arguments regardless of the length of the input vector.
# If it returns multiple value you can use "result\_variable" to control where they appear.
# By default they will appear as the last column variable.
#
# The margins argument should be passed a vector of variable names, eg.
# \code{c("month","day")}.  It will silently drop any variables that can not be margined 
# over.  You can also use "grand\_col" and "grand\_row" to get grand row and column margins
# respectively.
#
# Subset takes a logical vector that will be evaluated in the context of \code{data},
# so you can do something like \code{subset = variable=="length"}
#
# All the actual reshaping is done by \code{\link{reshape1}}, see its documentation
# for details of the implementation
#
# @keyword manip
# @arguments molten data frame, see \code{\link{melt}}
# @arguments casting formula, see details for specifics
# @arguments aggregation function
# @arguments further arguments are passed to aggregating function
# @arguments vector of variable names (can include "grand\_col" and "grand\_row") to compute margins for, or TRUE to computer all margins
# @arguments logical vector to subset data set with before reshaping
# @arguments argument used internally
# @arguments value with which to fill in structural missings, defaults to value from applying \code{fun.aggregate} to 0 length vector
# @argument should all missing combinations be displayed?
# @argument name of column which stores values, see \code{\link{guess_value}} for default strategies to figure this out
# @seealso \code{\link{reshape1}},  \url{http://had.co.nz/reshape/}
#X #Air quality example
#X names(airquality) <- tolower(names(airquality))
#X aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
#X 
#X cast(aqm, day ~ month ~ variable)
#X cast(aqm, month ~ variable, mean)
#X cast(aqm, month ~ . | variable, mean)
#X cast(aqm, month ~ variable, mean, margins=c("grand_row", "grand_col"))
#X cast(aqm, day ~ month, mean, subset=variable=="ozone")
#X cast(aqm, month ~ variable, range)
#X cast(aqm, month ~ variable + result_variable, range)
#X cast(aqm, variable ~ month ~ result_variable,range)
#X
#X #Chick weight example
#X names(ChickWeight) <- tolower(names(ChickWeight))
#X chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
#X 
#X cast(chick_m, time ~ variable, mean) # average effect of time
#X cast(chick_m, diet ~ variable, mean) # average effect of diet
#X cast(chick_m, diet ~ time ~ variable, mean) # average effect of diet & time
#X 
#X # How many chicks at each time? - checking for balance
#X cast(chick_m, time ~ diet, length)
#X cast(chick_m, chick ~ time, mean)
#X cast(chick_m, chick ~ time, mean, subset=time < 10 & chick < 20)
#X 
#X cast(chick_m, diet + chick ~ time)
#X cast(chick_m, chick ~ time ~ diet)
#X cast(chick_m, diet + chick ~ time, mean, margins="diet")
#X
#X #Tips example
#X cast(melt(tips), sex ~ smoker, mean, subset=variable=="total_bill")
#X cast(melt(tips), sex ~ smoker | variable, mean)
#X 
#X ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
#X cast(ff_d, subject ~ time, length)
#X cast(ff_d, subject ~ time, length, fill=0)
#X cast(ff_d, subject ~ time, function(x) 30 - length(x))
#X cast(ff_d, subject ~ time, function(x) 30 - length(x), fill=30)
#X cast(ff_d, variable ~ ., c(min, max))
#X cast(ff_d, variable ~ ., function(x) quantile(x,c(0.25,0.5)))
#X cast(ff_d, treatment ~ variable, mean, margins=c("grand_col", "grand_row"))
#X cast(ff_d, treatment + subject ~ variable, mean, margins="treatment")
cast <- function(data, formula = ... ~ variable, fun.aggregate=NULL, ..., margins=FALSE, subset=TRUE, df=FALSE, fill=NULL, add.missing=FALSE, value = guess_value(data)) {
  if (is.formula(formula))    formula <- deparse(formula)
  if (!is.character(formula)) formula <- as.character(formula)
  
  subset <- eval(substitute(subset), data, parent.frame())    
  subset <- !is.na(subset) & subset
  data <- data[subset, , drop=FALSE]  
  variables <- cast_parse_formula(formula, names(data))

  if (any(names(data) == value))  names(data)[names(data) == value] <- "value"

  v <- unlist(variables)
  v <- v[v != "result_variable"]
  if (add.missing) data[v] <- lapply(data[v], as.factor)

  if (length(fun.aggregate) > 1) 
    fun.aggregate <- do.call(funstofun, as.list(match.call()[[4]])[-1])
  if (!is.null(fun.aggregate) && is.character(fun.aggregate)) fun.aggregate <- match.fun(fun.aggregate)
  
  if (!is.null(variables$l)) {
    res <- nested.by(data, data[variables$l], function(x) {
      reshape1(x, variables$m, fun.aggregate, margins=margins, df=df, fill=fill, add.missing=add.missing, ...)
    })  
  } else {
    res <- reshape1(data, variables$m, fun.aggregate, margins=margins, df=df,fill=fill, add.missing=add.missing, ...)
  }
  #attr(res, "formula") <- formula
  #attr(res, "data") <- deparse(substitute(data))
  
  res
}

# Casting workhorse.
# Takes data frame and variable list and casts data.
#
# @arguments data frame
# @arguments variables to appear in columns
# @arguments variables to appear in rows
# @arguments aggregation function
# @arguments should the aggregating function be supplied with the entire data frame, or just the relevant entries from the values column
# @arguments vector of variable names (can include "grand\_col" and "grand\_row") to compute margins for, or TRUE to computer all margins
# @arguments value with which to fill in structural missings
# @arguments further arguments are passed to aggregating function
# @seealso \code{\link{cast}}
# @keyword internal
#X 
#X ffm <- melt(french_fries, id=1:4, na.rm = TRUE)
#X # Casting lists ----------------------------
#X cast(ffm, treatment ~ rep | variable, mean)
#X cast(ffm, treatment ~ rep | subject, mean)
#X cast(ffm, treatment ~ rep | time, mean)
#X cast(ffm, treatment ~ rep | time + variable, mean)
#X names(airquality) <- tolower(names(airquality))
#X aqm <- melt(airquality, id=c("month", "day"), preserve=FALSE)
#X #Basic call
#X reshape1(aqm, list("month", NULL), mean)
#X reshape1(aqm, list("month", "variable"), mean)
#X reshape1(aqm, list("day", "month"), mean)
#X 
#X #Explore margins  ----------------------------
#X reshape1(aqm, list("month", NULL), mean, "month")
#X reshape1(aqm, list("month", NULL) , mean, "grand_col")
#X reshape1(aqm, list("month", NULL) , mean, "grand_row")
#X 
#X reshape1(aqm, list(c("month", "day"), NULL), mean, "month")
#X reshape1(aqm, list(c("month"), "variable"), mean, "month")
#X reshape1(aqm, list(c("variable"), "month"), mean, "month")
#X reshape1(aqm, list(c("month"), "variable"), mean, c("month","variable"))
#X 
#X reshape1(aqm, list(c("month"), "variable"), mean, c("grand_row"))
#X reshape1(aqm, list(c("month"), "variable"), mean, c("grand_col"))
#X reshape1(aqm, list(c("month"), "variable"), mean, c("grand_row","grand_col"))
#X 
#X reshape1(aqm, list(c("variable","day"),"month"), mean,c("variable"))
#X reshape1(aqm, list(c("variable","day"),"month"), mean,c("variable","grand_row"))
#X reshape1(aqm, list(c("month","day"), "variable"), mean, "month") 
#X 
#X # Multiple fnction returns  ----------------------------
#X reshape1(aqm, list(c("month", "result_variable"), NULL), range) 
#X reshape1(aqm, list(c("month"),"result_variable") , range) 
#X reshape1(aqm, list(c("result_variable", "month"), NULL), range) 
#X 
#X reshape1(aqm, list(c("month", "result_variable"), "variable"), range, "month")
#X reshape1(aqm, list(c("month", "result_variable"), "variable"), range, "variable")
#X reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("variable","month"))
#X reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("grand_col"))
#X reshape1(aqm, list(c("month", "result_variable"), "variable"), range, c("grand_row"))
#X 
#X reshape1(aqm, list(c("month"), c("variable")), function(x) diff(range(x))) 
reshape1 <- function(data, vars = list(NULL, NULL), fun.aggregate=NULL, margins, df=FALSE, fill=NA, add.missing=FALSE, ...) {
  vars.clean <- lapply(vars, clean.vars)
  variables <- unlist(vars.clean)
  
  if (!missing(margins) && isTRUE(margins)) margins <- c(variables, "grand_row", "grand_col")
  
  aggregate <- nrow(unique(data[,variables, drop=FALSE])) < nrow(data) || !is.null(fun.aggregate)
  if (aggregate) {
    if (missing(fun.aggregate) || is.null(fun.aggregate)) {
      message("Aggregation requires fun.aggregate: length used as default")
      fun.aggregate <- length
    }

    if (is.null(fill)) {
      fill <- suppressWarnings(fun.aggregate(data$value[0]))
    }
    
    if (!df) {
      data.r <- expand(condense(data, variables, fun.aggregate, ...)) 
    } else {
      data.r <- condense.df(data, variables, fun.aggregate, ...)
    }
    if ("result_variable" %in% names(data.r) && !("result_variable" %in% unlist(vars))) {
      vars[[2]] <- c(vars[[2]], "result_variable")
    }
  } else {
    data.r <- data.frame(data[,c(variables), drop=FALSE], result = data$value)
    if (!is.null(fun.aggregate)) data.r$result <- sapply(data.r$result, fun.aggregate)
    
    if (is.null(fill)) {
      fill <- NA
    }
  }

  if (length(vars.clean) > 2 && margins) {
    warning("Sorry, you currently can't use margins with high D arrays", .call=FALSE)
    
    margins <- FALSE
  }
  margins.r <- compute.margins(data, margin.vars(vars.clean, margins), vars.clean, fun.aggregate, ..., df=df)

  if (ncol(margins.r) > 0) {
    need.factorising <- !sapply(data.r, is.factor) & sapply(margins.r, is.factor)             
    data.r[need.factorising] <- lapply(data.r[need.factorising], factor)
  }

  result <- sort_df(rbind.fill(data.r, margins.r), unlist(vars))
  
  if (add.missing) result <- add.missing.levels(result, unlist(vars), fill=fill)
  result <- add.all.combinations(result, vars, fill=fill)
  
  dimnames <- lapply(vars, function(x) dim_names(result, x))

  r <- if (!df) unlist(result$result) else result$result
  reshaped <- array(r, rev(sapply(dimnames, nrow)))
  
  reshaped <- aperm(reshaped, length(dim(reshaped)):1)
  dimnames(reshaped) <- lapply(dimnames, function(x) apply(x, 1, paste, collapse="-"))
  names(dimnames(reshaped)) <- lapply(vars, paste, collapse="-")
  
  if (length(vars.clean) > 2) return(reshaped)
  if (df) return(cast_matrix(reshaped, dimnames))
  as.data.frame(cast_matrix(reshaped, dimnames))
}


# Add all combinations
# Add all combinations of the given rows and columns to the data frames.
# 
# This function is used to ensure that we have a matrix of the appropriate
# dimensionaliy with no missing cells.
# 
# @arguments data.frame
# @arguments variables (list of character vectors)
# @arguments value to fill structural missings with 
# @keyword internal 
#X rdunif <- 
#X   function(n=20, min=0, max=10) floor(runif(n,min, max))
#X df <- data.frame(a = rdunif(), b = rdunif(),c = rdunif(), result=1:20)
#X add.all.combinations(df)
#X add.all.combinations(df, list("a", "b"))
#X add.all.combinations(df, list("a", "b"), fill=0)
#X add.all.combinations(df, list(c("a", "b")))
#X add.all.combinations(df, list("a", "b", "c"))
#X add.all.combinations(df, list(c("a", "b"), "c"))
#X add.all.combinations(df, list(c("a", "b", "c")))
add.all.combinations <- function(data, vars = list(NULL), fill=NA) {
  if (sum(sapply(vars, length)) == 0) return(data)

  all.combinations <- do.call(expand.grid.df, 
    lapply(vars, function(cols) data[, cols, drop=FALSE])
  )  
  result <- merge(data, all.combinations, by = unlist(vars), 
    sort = FALSE, all = TRUE) 

  # fill missings with fill value
  if (is.list(result$result)) {
    result$result[sapply(result$result, is.null)] <- fill
  } else {
    data_col <- matrix(!names(result) %in% unlist(vars), nrow=nrow(result), ncol=ncol(result), byrow=TRUE)
    result[is.na(result) & data_col] <- fill
  }

  sort_df(result, unlist(vars))
}

# Add in any missing values
# @keyword internal
add.missing.levels <- function(data, vars=NULL, fill=NA) {  
  if (is.null(vars)) return(data)
  cat <- sapply(data[,vars, drop=FALSE], is.factor)

  levels <- lapply(data[,vars, drop=FALSE][,cat, drop=FALSE], levels)
  allcombs <- do.call(expand.grid, levels)

  current <- unique(data[,vars, drop=FALSE])
  extras <- allcombs[!duplicated(rbind(current, allcombs))[-(1:nrow(current))], , drop=FALSE]

  result <- rbind.fill(data, extras)
  if (!is.na(fill)) result[is.na(result)] <- fill

  result
}



# Dimension names
# Convenience method for extracting row and column names 
# 
# @arguments data frame
# @arguments variables to use
# @keyword internal
dim_names <- function(data, vars) {
  if (!is.null(vars) && length(vars) > 0) {
    unique(data[,vars,drop=FALSE]) 
  } else {
    data.frame(value="(all)") # use fun.aggregate instead of "value"? 
  }
}
