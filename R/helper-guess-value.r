#' Guess name of value column
#'
#' Strategy:
#' \enumerate{
#'   \item Is value or (all) column present? If so, use that
#'   \item Otherwise, guess that last column is the value column
#' }
#'
#' @param df data frame to guess value column from
#' @keywords internal
guess_value <- function(df) {
  if ("value" %in% names(df)) return("value")
  if ("(all)" %in% names(df)) return("(all)")

  last <- names(df)[ncol(df)]
  message("Using ", last, " as value column: use value.var to override.")

  last
}
