# Melt
# Melt an object into a form suitable for easy casting.
#
# This the generic melt function. See the following functions
# for specific details for different data structures:
#
# \itemize{
#   \item \code{\link{melt.data.frame}} for data.frames
#   \item \code{\link{melt.array}} for arrays, matrices and tables
#   \item \code{\link{melt.list}} for lists
# }
#
# @keyword manip
# @arguments Data set to melt
# @arguments Other arguments passed to the specific melt method
melt <- function(data, ...) UseMethod("melt", data)

# Default melt function
# For vectors, make a column of a data frame
#
# @keyword internal
melt.default <- function(data, ...) {
  data.frame(value=data)
}

# Melt a list
# Melting a list recursively melts each component of the list and joins the results together
#
# @keyword internal
#X a <- as.list(1:4)
#X melt(a)
#X names(a) <- letters[1:4]
#X melt(a)
#X attr(a, "varname") <- "ID"
#X melt(a)
#X a <- list(matrix(1:4, ncol=2), matrix(1:6, ncol=2))
#X melt(a)
#X a <- list(matrix(1:4, ncol=2), array(1:27, c(3,3,3)))
#X melt(a)
#X melt(list(1:5, matrix(1:4, ncol=2)))
#X melt(list(list(1:3), 1, list(as.list(3:4), as.list(1:2))))
melt.list <- function(data, ..., level=1) {
  var <- nulldefault(attr(data, "varname"), paste("L", level, sep=""))
  names <- nulldefault(names(data), 1:length(data))
  parts <- lapply(data, melt, level=level+1, ...)

  namedparts <- mapply(function(x, name) {
   x[[var]] <- name
   x
  }, parts, names, SIMPLIFY=FALSE)
  do.call(rbind.fill, namedparts)
}

# Melt a data frame
# Melt a data frame into form suitable for easy casting.
#
# You need to tell melt which of your variables are id variables, and which
# are measured variables. If you only supply one of \code{id.vars} and
# \code{measure.vars}, melt will assume the remainder of the variables in the
# data set belong to the other. If you supply neither, melt will assume
# factor and character variables are id variables, and all others are
# measured.
#
# @arguments Data set to melt
# @arguments Id variables. If blank, will use all non measure.vars variables.  Can be integer (variable position) or string (variable name)
# @arguments Measured variables. If blank, will use all non id.vars variables. Can be integer (variable position) or string (variable name)
# @arguments Name of the variable that will store the names of the original variables
# @arguments Should NA values be removed from the data set?
# @arguments Old argument name, now deprecated
# @value molten data
# @keyword manip
# @seealso \url{http://had.co.nz/reshape/}
#X head(melt(tips))
#X names(airquality) <- tolower(names(airquality))
#X melt(airquality, id=c("month", "day"))
#X names(ChickWeight) <- tolower(names(ChickWeight))
#X melt(ChickWeight, id=2:4)
melt.data.frame <- function(data, id.vars, measure.vars, variable_name = "variable", na.rm = !preserve.na, preserve.na = TRUE, ...) {
  if (!missing(preserve.na))
    message("Use of preserve.na is now deprecated, please use na.rm instead")

  var <- melt_check(data, id.vars, measure.vars)

  if (length(var$measure) == 0) {
    return(data[, var$id, drop=FALSE])
  }

  ids <- data[,var$id, drop=FALSE]
  df <- do.call("rbind", lapply(var$measure, function(x) {
    data.frame(ids, x, data[, x])
  }))
  names(df) <- c(names(ids), variable_name, "value")

  df[[variable_name]] <- factor(df[[variable_name]], unique(df[[variable_name]]))

  if (na.rm) {
    df <- df[!is.na(df$value), , drop=FALSE]
  }
  rownames(df) <- NULL
  df
}

# Melt an array
# This function melts a high-dimensional array into a form that you can use \code{\link{cast}} with.
#
# This code is conceptually similar to \code{\link{as.data.frame.table}}
#
# @arguments array to melt
# @arguments variable names to use in molten data.frame
# @keyword manip
# @alias melt.matrix
# @alias melt.table
#X a <- array(1:24, c(2,3,4))
#X melt(a)
#X melt(a, varnames=c("X","Y","Z"))
#X dimnames(a) <- lapply(dim(a), function(x) LETTERS[1:x])
#X melt(a)
#X melt(a, varnames=c("X","Y","Z"))
#X dimnames(a)[1] <- list(NULL)
#X melt(a)
melt.array <- function(data, varnames = names(dimnames(data)), ...) {
  values <- as.vector(data)

  dn <- dimnames(data)
  if (is.null(dn)) dn <- vector("list", length(dim(data)))

  dn_missing <- sapply(dn, is.null)
  dn[dn_missing] <- lapply(dim(data), function(x) 1:x)[dn_missing]

  char <- sapply(dn, is.character)
  dn[char] <- lapply(dn[char], type.convert)
  indices <- do.call(expand.grid, dn)

  names(indices) <- varnames

  data.frame(indices, value=values)
}

melt.table <- melt.array
melt.matrix <- melt.array

# Melt cast data.frames
# Melt the results of a cast
#
# This can be useful when performning complex aggregations - melting
# the result of a cast will do it's best to figure out the correct variables
# to use as id and measured.
#
# @keyword internal
melt.cast_df <- function(data, drop.margins=TRUE, ...) {
  molten <- melt.data.frame(as.data.frame(data), id.vars=attr(data, "idvars"))

  cols <- rcolnames(data)
  rownames(cols) <- make.names(rownames(cols))

  molten <- cbind(molten[names(molten) != "variable"], cols[molten$variable, , drop=FALSE])

  if (drop.margins) {
      margins <- !complete.cases(molten[,names(molten) != "value", drop=FALSE])
    molten <- molten[!margins, ]
  }

  molten

}

# Melt cast matrices
# Melt the results of a cast
#
# Converts to a data frame and then uses \code{\link{melt.cast_df}}
#
# @keyword internal
melt.cast_matrix <- function(data, ...) {
  melt(as.data.frame(data))
}

# Melt check.
# Check that input variables to melt are appropriate.
#
# If id.vars or measure.vars are missing, \code{melt_check} will do its
# best to impute them.If you only
# supply one of id.vars and measure.vars, melt will assume the remainder of
# the variables in the data set belong to the other. If you supply neither,
# melt will assume character and factor variables are id variables,
# and all other are measured.
#
# @keyword internal
# @arguments data frame
# @arguments Vector of identifying variable names or indexes
# @arguments Vector of Measured variable names or indexes
# @value id list id variable names
# @value measure list of measured variable names
melt_check <- function(data, id.vars, measure.vars) {
  varnames <- names(data)
  if (!missing(id.vars) && is.numeric(id.vars)) id.vars <- varnames[id.vars]
  if (!missing(measure.vars) && is.numeric(measure.vars)) measure.vars <- varnames[measure.vars]

  if (!missing(id.vars)) {
    unknown <- setdiff(id.vars, varnames)
    if (length(unknown) > 0) {
      stop("id variables not found in data: ", paste(unknown, collapse=", "),
        call. = FALSE)
    }
  }

  if (!missing(measure.vars)) {
    unknown <- setdiff(measure.vars, varnames)
    if (length(unknown) > 0) {
      stop("measure variables not found in data: ", paste(unknown, collapse=", "),
        call. = FALSE)
    }
  }

  if (missing(id.vars) && missing(measure.vars)) {
    categorical <- sapply(data, function(x) class(x)[1]) %in% c("factor", "ordered", "character")
    id.vars <- varnames[categorical]
    measure.vars <- varnames[!categorical]
    message("Using ", paste(id.vars, collapse=", "), " as id variables")
  }

  if (missing(id.vars)) id.vars <- varnames[!(varnames %in% c(measure.vars))]
  if (missing(measure.vars)) measure.vars <- varnames[!(varnames %in% c(id.vars))]

  list(id = id.vars, measure = measure.vars)
}
