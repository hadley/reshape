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
#' @seealso \code{\link{cast}}
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
#' @keywords manip
#' @seealso \code{\link{melt}}, \code{\link{cast}}
#' @family melt methods
#' @export
melt.default <- function(data, ..., na.rm = FALSE, value.name = "value") {
  if (na.rm) data <- data[!is.na(data)]
  setNames(data.frame(data), value.name)
}

#' Melt a list by recursively melting each component.
#'
#' @keywords manip
#' @param data list to recursively melt
#' @param ... further arguments passed to or from other methods.
#' @param level list level - used for creating labels
#' @seealso \code{\link{cast}}
#' @family melt methods
#' @export
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
#'   or string (variable name). If blank, will use all non-measured variables.
#' @param measure.vars vector of measured variables. Can be integer (variable
#'   position) or string (variable name)If blank, will use all non id.vars
#    variables.
#' @param variable.name name of variable used to store measured variable names
#' @param value.name name of variable used to store values
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @param ... further arguments passed to or from other methods.
#' @param factorsAsStrings Control whether factors are converted to character
#'   when melted as measure variables. When \code{FALSE}, coercion is forced if
#'   levels are not identical across the \code{measure.vars}.
#' @family melt methods
#' @keywords manip
#' @seealso \code{\link{cast}}
#' @export
#' @examples
#' names(airquality) <- tolower(names(airquality))
#' melt(airquality, id=c("month", "day"))
#' names(ChickWeight) <- tolower(names(ChickWeight))
#' melt(ChickWeight, id=2:4)
melt.data.frame <- function(data, id.vars, measure.vars, variable.name = "variable", ..., na.rm = FALSE, value.name = "value", factorsAsStrings = TRUE) {

  ## Get the names of id.vars, measure.vars
  vars <- melt_check(data, id.vars, measure.vars, variable.name, value.name)

  ## Match them to indices in the data
  id.ind <- match(vars$id, names(data))
  measure.ind <- match(vars$measure, names(data))

  ## Return early if we have id.ind but no measure.ind
  if (!length(measure.ind)) {
    return(data[id.vars])
  }

  ## Get the attributes if common, NULL if not.
  args <- normalize_melt_arguments(data, measure.ind, factorsAsStrings)
  measure.attributes <- args$measure.attributes
  factorsAsStrings <- args$factorsAsStrings
  valueAsFactor <- "factor" %in% measure.attributes$class

  df <- melt_dataframe(
    data,
    as.integer(id.ind-1),
    as.integer(measure.ind-1),
    as.character(variable.name),
    as.character(value.name),
    as.pairlist(measure.attributes),
    as.logical(factorsAsStrings),
    as.logical(valueAsFactor)
  )

  if (na.rm) {
    return(df[ !is.na(df[[value.name]]), ])
  } else {
    return(df)
  }
}

#' Melt an array.
#'
#' This code is conceptually similar to \code{\link{as.data.frame.table}}
#'
#' @param data array to melt
#' @param varnames variable names to use in molten data.frame
#' @param ... further arguments passed to or from other methods.
#' @param as.is if \code{FALSE}, the default, dimnames will be converted
#'   using \code{\link{type.convert}}. If \code{TRUE}, they will be left
#'   as strings.
#' @param value.name name of variable used to store values
#' @param na.rm Should NA values be removed from the data set? This will
#'   convert explicit missings to implicit missings.
#' @keywords manip
#' @export
#' @seealso \code{\link{cast}}
#' @family melt methods
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
melt.array <- function(data, varnames = names(dimnames(data)), ...,
                       na.rm = FALSE, as.is = FALSE, value.name = "value") {
  var.convert <- function(x) {
    if (!is.character(x)) return(x)

    x <- type.convert(x, as.is = TRUE)
    if (!is.character(x)) return(x)

    factor(x, levels = unique(x))
  }

  dn <- amv_dimnames(data)
  names(dn) <- varnames
  if (!as.is) {
    dn <- lapply(dn, var.convert)
  }

  labels <- expand.grid(dn, KEEP.OUT.ATTRS = FALSE,
    stringsAsFactors = FALSE)

  if (na.rm) {
    missing <- is.na(data)
    data <- data[!missing]
    labels <- labels[!missing, ]
  }

  value_df <- setNames(data.frame(as.vector(data)), value.name)
  cbind(labels, value_df)
}

#' @rdname melt.array
#' @export
melt.table <- melt.array

#' @rdname melt.array
#' @export
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
#' @param variable.name name of variable used to store measured variable names
#' @param value.name name of variable used to store values
#' @return a list giving id and measure variables names.
melt_check <- function(data, id.vars, measure.vars, variable.name, value.name) {
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
    if (length(id.vars) != 0) {
      message("Using ", paste(id.vars, collapse = ", "), " as id variables")
    } else {
      message("No id variables; using all as measure variables")
    }
  } else if (missing(id.vars)) {
    id.vars <- setdiff(varnames, measure.vars)
  } else if (missing(measure.vars)) {
    measure.vars <- setdiff(varnames, id.vars)
  }

  # Ensure variable names are characters of length one
  if (!is.string(variable.name))
    stop("'variable.name' should be a string", call. = FALSE)
  if (!is.string(value.name))
    stop("'value.name' should be a string", call. = FALSE)

  list(id = id.vars, measure = measure.vars)
}
