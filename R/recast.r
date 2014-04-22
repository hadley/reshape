#' Recast: melt and cast in a single step
#'
#' This conveniently wraps melting and (d)casting a data frame into
#' a single step.
#'
#' @param data data set to melt
#' @param formula casting formula, see \code{\link{dcast}} for specifics
#' @param ... other arguments passed to \code{\link{dcast}}
#' @param id.var identifying variables. If blank, will use all non
#'    measure.var variables
#' @param measure.var measured variables. If blank, will use all non
#'    id.var variables
#' @keywords manip
#' @seealso \url{http://had.co.nz/reshape/}
#' @export
#' @examples
#' recast(french_fries, time ~ variable, id.var = 1:4)
recast <- function(data, formula, ..., id.var, measure.var) {
  if (any(c("id.vars", "measure.vars") %in% names(match.call()))) {
    stop("Use var, not vars\n")
  }

  molten <- melt(data, id.var, measure.var)
  dcast(molten, formula, ...)
}
