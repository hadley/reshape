#' Recast: melt and cast in a single step
#' 
#' This conveniently wraps melting and casting a data frame into
#' a single step. 
#'
#' @arguments data data set to melt
#' @arguments formula casting formula, see \link{cast} for specifics
#' @arguments ... other arguments passed to \link{cast}
#' @arguments id.var identifying variables. If blank, will use all non
#'    measure.var variables
#' @arguments measure.var measured variables. If blank, will use all non
#'    id.var variables
#' @keyword manip
#' @seealso \url{http://had.co.nz/reshape/}
#' @examples
#' recast(french_fries, time ~ variable, id.var = 1:4)
recast <- function(data, formula, ..., id.var, measure.var) {
  
  if (any(c("id.vars", "measure.vars") %in% names(list(...)))) {
    stop("Use var, not vars\n")
  }
  
  molten <- melt(data, id.var, measure.var)
  cast(molten, formula, ...)
}
