#' Figure out margining variables.
#'
#' Given the variables that form the rows and columns, and a set of desired
#' margins, works out which ones are possible. Variables that can't be
#' margined over are dropped silently.
#'
#' @param vars a list of character vectors giving the variables in each
#'   dimension
#' @param margins a character vector of variable names to compute margins for.
#'   \code{TRUE} will compute all possible margins.
#' @keywords manip internal
#' @return list of margining combinations, or \code{NULL} if none. These are
#'   the combinations of variables that should have their values set to
#'   \code{(all)}
margins <- function(vars, margins = NULL) {
  if (is.null(margins) || identical(margins, FALSE)) return(NULL)

  all_vars <- unlist(vars)
  if (isTRUE(margins)) {
    margins <- all_vars
  }

  # Start by grouping margins by dimension
  dims <- lapply(vars, intersect, margins)

  # Next, ensure high-level margins include lower-levels
  dims <- mapply(function(vars, margin) {
    lapply(margin, downto, vars)
  }, vars, dims, SIMPLIFY = FALSE, USE.NAMES = FALSE)

  # Finally, find intersections across all dimensions
  seq_0 <- function(x) c(0, seq_along(x))
  indices <- expand.grid(lapply(dims, seq_0), KEEP.OUT.ATTRS = FALSE)
  # indices <- indices[rowSums(indices) > 0, ]

  lapply(seq_len(nrow(indices)), function(i){
    unlist(mapply("[", dims, indices[i, ], SIMPLIFY = FALSE))
  })
}

upto <- function(a, b) {
  b[seq_len(match(a, b, nomatch = 0))]
}
downto <- function(a, b) {
  rev(upto(a, rev(b)))
}

#' Add margins to a data frame.
#'
#' Rownames are silently stripped. All margining variables will be converted
#' to factors.
#'
#' @param df input data frame
#' @param vars a list of character vectors giving the variables in each
#'   dimension
#' @param margins a character vector of variable names to compute margins for.
#'   \code{TRUE} will compute all possible margins.
#' @export
add_margins <- function(df, vars, margins = TRUE) {
  margin_vars <- margins(vars, margins)

  # Return data frame if no margining necessary
  if (length(margin_vars) == 0) return(df)

  # Prepare data frame for addition of margins
  addAll <- function(x) {
    x <- addNA(x, TRUE)
    factor(x, levels = c(levels(x), "(all)"), exclude = NULL)
  }
  vars <- unique(unlist(margin_vars))
  df[vars] <- lapply(df[vars], addAll)

  rownames(df) <- NULL

  # Loop through all combinations of margin variables, setting
  # those variables to (all)
  margin_dfs <- llply(margin_vars, function(vars) {
    df[vars] <- rep(list(factor("(all)")), length(vars))
    df
  })

  rbind.fill(margin_dfs)
}
