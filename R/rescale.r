# Rescaler
# Convenient methods for rescaling data
# 
# Provides methods for vectors, matrices and data.frames
# 
# Currently, five rescaling options are implemented:
# 
# \itemize{
#   \item \code{I}: do nothing
#   \item \code{range}: scale to [0, 1] 
#   \item \code{rank}: convert values to ranks
#   \item \code{robust}: robust version of \code{sd}, substract median and divide by median absolute deviation
#   \item \code{sd}: subtract mean and divide by standard deviation
# }
# 
# @arguments object to rescale
# @arguments type of rescaling to use (see description for details)
# @arguments other options (only pasesed to \code{\link{rank}})
# @keyword manip 
# @seealso \code{\link{rescaler.default}}
rescaler <- function(x, type="sd", ...) UseMethod("rescaler", x)


# Default rescaler
# See \code{\link{rescaler}} for details
# 
# @arguments vector to rescale
# @arguments type of rescaling to apply
# @arguments other arguments passed to rescaler 
# @keyword internal 
rescaler.default <- function(x, type="sd", ...) {
  switch(type,
    rank = rank(x, ...),
    var = ,
    sd = (x - mean(x, na.rm=TRUE)) / sd(x, na.rm=TRUE),
    robust = (x - median(x, na.rm=TRUE)) / mad(x, na.rm=TRUE),
    I = x,
    range = (x - min(x, na.rm=TRUE)) / diff(range(x, na.rm=TRUE))
  )
}

# Rescale a data frame
# Rescales data frame by columns
# 
# @arguments data.frame to rescale
# @arguments type of rescaling to apply
# @arguments other arguments passed to rescaler 
# @keyword internal
rescaler.data.frame <- function(x, type="sd", ...) {
  continuous <- sapply(x, is.numeric)
  x[continuous] <- lapply(x[continuous], rescaler, type=type, ...)
  x
}

# Rescale a matrix
# Rescales matrix by columns
# 
# @arguments matrix to rescale
# @arguments type of rescaling to apply
# @arguments other arguments passed to rescaler 
# @keyword internal
rescaler.matrix <- function(x, type="sd", ...) {
  apply(x, 2, rescaler, type=type, ...)
}