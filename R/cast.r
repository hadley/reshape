#' Cast functions
#' Cast a molten data frame into an array or data frame.
#'
#' Use \code{acast} or \code{dcast} depending on whether you want 
#' vector/matrix/array output or data frame output.  Data frames can have at 
#' most two dimensions.
#'
#' The cast formula has the following format: 
#' \code{x_variable + x_2 ~ y_variable + y_2 ~ z_variable ~  ... }
#' The order of the variables makes a difference.  The first varies slowest,
#' and the last fastest.  There are a couple of special variables: "..."
#' represents all other variables not used in the formula and "." represents 
#' no variable, so you can do \code{formula = var1 ~ .}.  
#'
#' Alternatively, you can supply a list of quoted expressions, in the form
#' \code{list(.(x_variable, x_2), .(y_variable, y_2), .(z))}.  The advantage
#' of this form is that you can cast based on transformations of the
#' variables: \code{list(.(a + b), (c = round(c)))}.  See the documentation
#' for \code{\link[plyr]{.}} for more details and alternative formats.
#'
#' If the combination of variables you supply does not uniquely identify one
#' row in the original data set, you will need to supply an aggregating
#' function, \code{fun.aggregate}. This function should take a vector of
#' numbers and return a single summary statistic.
#'
#' @usage acast(data, formula, fun.aggregate = NULL, ..., margins = NULL,
#'    subset = NULL, fill=NULL, drop = TRUE, value_var = guess_value(data))
#' @usage dcast(data, formula, fun.aggregate = NULL, ..., margins = NULL,
#'    subset = NULL, fill=NULL, drop = TRUE, value_var = guess_value(data))
#' @keywords manip
#' @param data molten data frame, see \code{\link{melt}}.
#' @param formula casting formula, see details for specifics.
#' @param fun.aggregate aggregation function needed if variables do not 
#'   identify a single observation for each output cell.  Defaults to length
#'   (with a message) if needed but not specified.
#' @param ... further arguments are passed to aggregating function
#' @param margins vector of variable names (can include "grand\_col" and
#'   "grand\_row") to compute margins for, or TRUE to compute all margins .
#'   Any variables that can not be margined over will be silently dropped.
#' @param subset quoted expression used to subset data prior to reshaping,
#'   e.g. \code{subset = .(variable=="length")}.
#' @param fill value with which to fill in structural missings, defaults to
#'   value from applying \code{fun.aggregate} to 0 length vector
#' @param drop should missing combinations dropped or kept?
#' @param value_var name of column which stores values, see
#'   \code{\link{guess_value}} for default strategies to figure this out.
#' @seealso \code{\link{melt}},  \url{http://had.co.nz/reshape/}
#' @name cast
#' @aliases cast dcast acast
#' @export dcast acast
#' @import plyr
#' @import stringr
#' @examples
#' #Air quality example
#' names(airquality) <- tolower(names(airquality))
#' aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
#' 
#' acast(aqm, day ~ month ~ variable)
#' acast(aqm, month ~ variable, mean)
#' acast(aqm, month ~ variable, mean, margins = TRUE)
#' dcast(aqm, month ~ variable, mean, margins = c("month", "variable"))
#'
#' library(plyr) # needed to access . function
#' acast(aqm, variable ~ month, mean, subset = .(variable == "ozone"))
#' acast(aqm, variable ~ month, mean, subset = .(month == 5))
#'
#' #Chick weight example
#' names(ChickWeight) <- tolower(names(ChickWeight))
#' chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
#' 
#' dcast(chick_m, time ~ variable, mean) # average effect of time
#' dcast(chick_m, diet ~ variable, mean) # average effect of diet
#' acast(chick_m, diet ~ time, mean) # average effect of diet & time
#' 
#' # How many chicks at each time? - checking for balance
#' acast(chick_m, time ~ diet, length)
#' acast(chick_m, chick ~ time, mean)
#' acast(chick_m, chick ~ time, mean, subset = .(time < 10 & chick < 20))
#' 
#' acast(chick_m, time ~ diet, length)
#' 
#' dcast(chick_m, diet + chick ~ time)
#' acast(chick_m, diet + chick ~ time)
#' acast(chick_m, chick ~ time ~ diet)
#' acast(chick_m, diet + chick ~ time, length, margins="diet")
#' acast(chick_m, diet + chick ~ time, length, drop = FALSE)
#' 
#' #Tips example
#' dcast(melt(tips), sex ~ smoker, mean, subset = .(variable == "total_bill"))
#' 
#' ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
#' acast(ff_d, subject ~ time, length)
#' acast(ff_d, subject ~ time, length, fill=0)
#' dcast(ff_d, treatment ~ variable, mean, margins = TRUE)
#' dcast(ff_d, treatment + subject ~ variable, mean, margins="treatment")
#' lattice::xyplot(`1` ~ `2` | variable, dcast(ff_d, ... ~ rep), aspect="iso")
NULL

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
  overall <- id(rev(ids), drop = FALSE)
  
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
    data <- add_margins(data, lapply(formula, names), margins)
  }
  
  res <- cast(data, formula, fun.aggregate, ..., 
    subset = subset, fill = fill, drop = drop, 
    value_var = value_var)

  data <- as.data.frame(res$data)
  names(data) <- array_names(res$labels[[2]])
  
  cbind(res$labels[[1]], data)
}

acast <- function(data, formula, fun.aggregate = NULL, ..., margins = NULL, subset = NULL, fill=NULL, drop = TRUE, value_var = guess_value(data)) {

  formula <- parse_formula(formula, names(data), value_var)
  
  if (!is.null(margins)) {
    data <- add_margins(data, lapply(formula, names), margins)    
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
