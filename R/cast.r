#' Cast function
#' Cast a molten data frame into the reshaped or aggregated form you want
#'
#' The cast formula has the following format: 
#' \code{x_variable + x_2 ~ y_variable + y_2 ~ z_variable ~  ... }
#' The order of the variables makes a difference.  The first varies slowest,
#' and the last fastest.  There are a couple of special variables: "..."
#' represents all other variables not used in the formula and "." represents 
#' no variable, so you can do \code{formula = var1 ~ .}
#'
#' If the combination of variables you supply does not uniquely identify one
#' row in the original data set, you will need to supply an aggregating
#' function, \code{fun.aggregate}. This function should take a vector of
#' numbers and return a single summary statistic.
#'
#' The margins argument should be passed a vector of variable names, eg.
#' \code{c("month","day")}.  It will silently drop any variables that can not
#' be margined over.  You can also use "grand\_col" and "grand\_row" to get
#' grand row and column margins respectively.
#'
#' Subset takes a quoted value that will be evaluated in the context of 
#' the \code{data}, so you can do something like 
#' \code{subset = .(variable=="length")}.
#'
#' @keywords manip
#' @param data molten data frame, see \code{\link{melt}}
#' @param formula casting formula, see details for specifics
#' @param fun.aggregate aggregation function
#' @param ... further arguments are passed to aggregating function
#' @param margins vector of variable names (can include "grand\_col" and
#'   "grand\_row") to compute margins for, or TRUE to compute all margins
#' @param subset quoted expression used to subset data prior to reshaping
#' @param fill value with which to fill in structural missings, defaults to
#'   value from applying \code{fun.aggregate} to 0 length vector
#' @param drop should missing combinations dropped or kept?
#' @param value_var name of column which stores values, see
#'   \code{\link{guess_value}} for default strategies to figure this out.
#' @seealso \code{\link{reshape1}},  \url{http://had.co.nz/reshape/}
#' @examples
#' #Air quality example
#' names(airquality) <- tolower(names(airquality))
#' aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
#' 
#' cast(aqm, day ~ month ~ variable)
#' cast(aqm, month ~ variable, mean)
#' cast(aqm, month ~ . | variable, mean)
#' cast(aqm, month ~ variable, mean, margins=c("grand_row", "grand_col"))
#' cast(aqm, day ~ month, mean, subset=variable=="ozone")
#' cast(aqm, month ~ variable, range)
#' cast(aqm, month ~ variable + result_variable, range)
#' cast(aqm, variable ~ month ~ result_variable,range)
#'
#' #Chick weight example
#' names(ChickWeight) <- tolower(names(ChickWeight))
#' chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
#' 
#' cast(chick_m, time ~ variable, mean) # average effect of time
#' cast(chick_m, diet ~ variable, mean) # average effect of diet
#' cast(chick_m, diet ~ time ~ variable, mean) # average effect of diet & time
#' 
#' # How many chicks at each time? - checking for balance
#' cast(chick_m, time ~ diet, length)
#' cast(chick_m, chick ~ time, mean)
#' cast(chick_m, chick ~ time, mean, subset=time < 10 & chick < 20)
#' 
#' cast(chick_m, diet + chick ~ time)
#' cast(chick_m, chick ~ time ~ diet)
#' cast(chick_m, diet + chick ~ time, mean, margins="diet")
#'
#' #Tips example
#' cast(melt(tips), sex ~ smoker, mean, subset=variable=="total_bill")
#' cast(melt(tips), sex ~ smoker | variable, mean)
#' 
#' ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
#' cast(ff_d, subject ~ time, length)
#' cast(ff_d, subject ~ time, length, fill=0)
#' cast(ff_d, subject ~ time, function(x) 30 - length(x))
#' cast(ff_d, subject ~ time, function(x) 30 - length(x), fill=30)
#' cast(ff_d, variable ~ ., c(min, max))
#' cast(ff_d, variable ~ ., function(x) quantile(x,c(0.25,0.5)))
#' cast(ff_d, treatment ~ variable, mean, margins=c("grand_col", "grand_row"))
#' cast(ff_d, treatment + subject ~ variable, mean, margins="treatment")
#' lattice::xyplot(`1` ~ `2` | variable, cast(ff_d, ... ~ rep), aspect="iso")
cast <- function(data, formula, fun.aggregate = NULL, ..., subset = NULL, fill = NULL, drop = TRUE, value_var = guess_value(data)) {
  
  if (!is.null(subset)) {
    include <- data.frame(eval.quoted(subset, data))
    data <- data[rowSums(include) == ncol(include), ]
  }
  
  formula <- parse_formula(formula, names(data), value_var)
  value <- data[[value_var]]
  
  # Need to branch here depending on whether or not we have strings or
  # expressions - strings should avoid making copies of the data
  vars <- lapply(formula, eval.quoted, envir = data, enclos = parent.frame())
  
  
  # Compute labels and id values
  ids <- lapply(vars, id, drop = drop)
  labels <- mapply(split_labels, vars, ids, MoreArgs = list(drop = drop),
    SIMPLIFY = FALSE, USE.NAMES = FALSE)
  overall <- id(rev(ids))
  
  ns <- vapply(ids, attr, 0, "n")
  n <- attr(overall, "n")
  
  # Aggregate duplicates
  if (any(duplicated(overall)) || !is.null(fun.aggregate)) {
    if (is.null(fun.aggregate)) {
      message("Aggregation function missing: defaulting to length")
      fun.aggregate <- length
    }
    
    ordered <- vaggregate(.value = value, .group = overall, 
      .fun = fun.aggregate, ...,  .default = fill, .n = n)
    overall <- seq_len(n)
    
  } else {
    # Add in missing values, if necessary
    if (length(overall) < n) {
      overall <- match(seq_len(n), overall, nomatch = NA)
    } else {
      overall <- order(overall)
    } 
    
    ordered <- value[overall]
    if (!is.null(fill)) {
      ordered[is.na(ordered)] <- fill
    }
  }
  
  list(
    data = structure(ordered, dim = ns),
    labels = labels
  )
}

dcast <- function(data, formula, fun.aggregate = NULL, ..., margins = NULL, subset = NULL, fill=NULL, drop = TRUE, value_var = guess_value(data))  {

  formula <- parse_formula(formula, names(data), value_var)
  if (length(formula) > 2) {
    stop("Dataframes have at most two output dimensions")
  }
  
  if (!is.null(margins)) {
    data <- add_margins(data, names(formula[[1]]), names(formula[[2]]),
      margins)
  }
  
  res <- cast(data, formula, fun.aggregate, ..., 
    subset = subset, fill = fill, drop = drop, 
    value_var = value_var)

  data <- as.data.frame(res$data)
  names(data) <- array_names(res$labels[[2]])
  
  cbind(res$labels[[1]], data)
}

acast <- function(data, formula, fun.aggregate = NULL, ..., margins = NULL, subset = NULL, fill=NULL, drop = TRUE, value_var = guess_value(data))  {

  formula <- parse_formula(formula, names(data), value_var)
  
  if (!is.null(margins)) {
    if (length(formula) > 2) {
      stop("Margins only work for up to two variables")
    }
    data <- add_margins(data, names(formula[[1]]), names(formula[[2]]),
      margins)    
  }
  
  res <- cast(data, formula, fun.aggregate, ..., 
    subset = subset, fill = fill, drop = drop, value_var = value_var)

  dimnames(res$data) <- lapply(res$labels, array_names)
  res$data
}

array_names <- function(df) {
  rows <- split(df, seq_len(nrow(df)))
  vapply(rows, splat(str_c), character(1), sep = "_", USE.NAMES = FALSE)
}
