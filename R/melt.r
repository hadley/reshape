#' Convert an object into a molten data frame.
#'
#' This the generic melt function. See the following functions
#' for the details about different data structures:
#'
#' \itemize{
#'   \item \code{\link{melt.data.frame}} for data.frames
#'   \item \code{\link{melt.array}} for arrays, matrices and tables
#'   \item \code{\link{melt.list}} for lists
#' }
#'
#' @keywords manip
#' @param data Data set to melt
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @param ... further arguments passed to or from other methods.
#' @param value.name name of variable used to store values
#' @export
melt <- function(data, ..., na.rm = FALSE, value.name = "value") {
  UseMethod("melt", data)
}

#' Melt a vector.
#' For vectors, makes a column of a data frame
#'
#' @param data vector to melt
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @param ... further arguments passed to or from other methods.
#' @param value.name name of variable used to store values
#' @S3method melt default
#' @method melt default
#' @keywords manip
melt.default <- function(data, ..., na.rm = FALSE, value.name = "value") {
  if (na.rm) data <- data[!is.na(data)]
  setNames(data.frame(data), value.name)
}

#' Melt a list by recursively melting each component.
#'
#' @keywords manip
#' @S3method melt list
#' @method melt list
#' @param data list to recursively melt
#' @param ... further arguments passed to or from other methods.
#' @param level list level - used for creating labels
#' @examples
#' a <- as.list(c(1:4, NA))
#' melt(a)
#' names(a) <- letters[1:4]
#' melt(a)
#' a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
#' melt(a)
#' a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
#' melt(a)
#' melt(list(1:5, matrix(1:4, ncol=2)))
#' melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))
melt.list <- function(data, ..., level = 1) {
  parts <- lapply(data, melt, level = level + 1, ...)
  result <- rbind.fill(parts)

  # Add labels
  names <- names(data) %||% seq_along(data)
  lengths <- vapply(parts, nrow, integer(1))
  labels <- rep(names, lengths)

  label_var <- attr(data, "varname") %||% paste("L", level, sep = "")
  result[[label_var]] <- labels

  # result <- cbind(labels, result)
  # result[, c(setdiff(names(result), "value"), "value")]

  result
}

#' Melt a data frame into form suitable for easy casting.
#'
#' You need to tell melt which of your variables are id variables, and which
#' are measured variables. If you only supply one of \code{id.vars} and
#' \code{measure.vars}, melt will assume the remainder of the variables in the
#' data set belong to the other. If you supply neither, melt will assume
#' factor and character variables are id variables, and all others are
#' measured.
#'
#' @param data data frame to melt
#' @param id.vars vector of id variables. Can be integer (variable position)
#'   or string (variable name)If blank, will use all non-measured variables.
#' @param measure.vars vector of measured variables. Can be integer (variable
#'   position) or string (variable name)If blank, will use all non id.vars
#    variables.
#' @param variable.name name of variable used to store measured variable names
#' @param value.name name of variable used to store values
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @param ... further arguments passed to or from other methods.
#' @keywords manip
#' @method melt data.frame
#' @S3method melt data.frame
#' @examples
#' names(airquality) <- tolower(names(airquality))
#' melt(airquality, id=c("month", "day"))
#' names(ChickWeight) <- tolower(names(ChickWeight))
#' melt(ChickWeight, id=2:4)
melt.data.frame <- function(data, id.vars, measure.vars, variable.name = "variable", ..., na.rm = FALSE, value.name = "value") {
  var <- melt_check(data, id.vars, measure.vars)

  ids <- unrowname(data[, var$id, drop = FALSE])
  if (length(var$measure) == 0) {
    return(ids)
  }

  # Turn factors to characters
  factors <- vapply(data, is.factor, logical(1))
  data[factors] <- lapply(data[factors], as.character)

  value <- unlist(unname(data[var$measure]))
  variable <- factor(rep(var$measure, each = nrow(data)),
    levels = var$measure)

  df <- data.frame(ids, variable, value, stringsAsFactors = FALSE)
  names(df) <- c(names(ids), variable.name, value.name)

  if (na.rm) {
    subset(df, !is.na(value))
  } else {
    df
  }
}

#' Melt an array.
#'
#' This code is conceptually similar to \code{\link{as.data.frame.table}}
#'
#' @param data array to melt
#' @param varnames variable names to use in molten data.frame
#' @param ... further arguments passed to or from other methods.
#' @param value.name name of variable used to store values
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @keywords manip
#' @S3method melt table
#' @S3method melt matrix
#' @S3method melt array
#' @method melt array
#' @examples
#' a <- array(c(1:23, NA), c(2,3,4))
#' melt(a)
#' melt(a, na.rm = TRUE)
#' melt(a, varnames=c("X","Y","Z"))
#' dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
#' melt(a)
#' melt(a, varnames=c("X","Y","Z"))
#' dimnames(a)[1] <- list(NULL)
#' melt(a)
melt.array <- function(data, varnames = names(dimnames(data)), ..., na.rm = FALSE, value.name = "value") {
  var.convert <- function(x) if(is.character(x)) type.convert(x) else x

  dn <- amv_dimnames(data)
  names(dn) <- varnames
  labels <- expand.grid(lapply(dn, var.convert), KEEP.OUT.ATTRS = FALSE,
    stringsAsFactors = FALSE)

  if (na.rm) {
    missing <- is.na(data)
    data <- data[!missing]
    labels <- labels[!missing, ]
  }

  value_df <- setNames(data.frame(as.vector(data)), value.name)
  cbind(labels, value_df)
}

melt.table <- melt.array
melt.matrix <- melt.array

#' Check that input variables to melt are appropriate.
#'
#' If id.vars or measure.vars are missing, \code{melt_check} will do its
#' best to impute them. If you only supply one of id.vars and measure.vars,
#' melt will assume the remainder of the variables in the data set belong to
#' the other. If you supply neither, melt will assume discrete variables are
#' id variables and all other are measured.
#'
#' @param data data frame
#' @param id.vars vector of identifying variable names or indexes
#' @param measure.vars vector of Measured variable names or indexes
#' @return a list giving id and measure variables names.
melt_check <- function(data, id.vars, measure.vars) {
  varnames <- names(data)

  # Convert positions to names
  if (!missing(id.vars) && is.numeric(id.vars)) {
    id.vars <- varnames[id.vars]
  }
  if (!missing(measure.vars) && is.numeric(measure.vars)) {
    measure.vars <- varnames[measure.vars]
  }

  # Check that variables exist
  if (!missing(id.vars)) {
    unknown <- setdiff(id.vars, varnames)
    if (length(unknown) > 0) {
      vars <- paste(unknown, collapse=", ")
      stop("id variables not found in data: ", vars, call. = FALSE)
    }
  }

  if (!missing(measure.vars)) {
    unknown <- setdiff(measure.vars, varnames)
    if (length(unknown) > 0) {
      vars <- paste(unknown, collapse=", ")
      stop("measure variables not found in data: ", vars, call. = FALSE)
    }
  }

  # Fill in missing pieces
  if (missing(id.vars) && missing(measure.vars)) {
    discrete <- sapply(data, is.discrete)
    id.vars <- varnames[discrete]
    measure.vars <- varnames[!discrete]
    message("Using ", paste(id.vars, collapse = ", "), " as id variables")
  } else if (missing(id.vars)) {
    id.vars <- setdiff(varnames, measure.vars)
  } else if (missing(measure.vars)) {
    measure.vars <- setdiff(varnames, id.vars)
  }

  list(id = id.vars, measure = measure.vars)
}
