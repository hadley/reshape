
add.margins <- function(data, vars, margins) {
	if (length(margins) == 0) return(data)
	
	# Ensure all variables are factors, and have level (all)
	data[vars] <- lapply(data[vars], as.factor)
	data[vars] <- lapply(data[vars], function(x) {
	  levels(x) <- c(levels(x), "(all)"); x
	})

	margin <- function(v) {
		over <- setdiff(unlist(vars), v)
		data[, over] <- rep(factor("(all)"), length(over))
		data
	}
	out <- do.call("rbind", lapply(margins, margin))
	rbind(data, out)

}


# Margin variables
# Works out list of variables to margin over to get desired margins.
#
# Variables that can't be margined over are dropped silently.
#
# @arguments column variables
# @arguments row variables
# @arguments vector of variable names to margin over.
# @keyword internal
margin.vars <- function(vars = list(NULL, NULL), margins = NULL) {
	rows <- vars[[1]]
	cols <- vars[[2]]
	
	if (missing(margins) || is.null(margins) || margins == FALSE) return(NULL)
	
	# Nothing to margin over for last variable in column or row
	row.margins <- intersect(rows[-length(rows)], margins)
	if (length(row.margins) == 0 ) row.margins <- NULL
	col.margins <- intersect(cols[-length(cols)], margins)
	if (length(col.margins) == 0 ) col.margins <- NULL

	grand.row <- "grand_row" %in% margins
	grand.col <- "grand_col" %in% margins
	
	margin.intersect <- function(cols, col.margins, rows, row.margins) {
		unlist(lapply(col.margins, function(col) {
			c(lapply(row.margins, c, col), list(c(col, rows)))
		}), recursive = FALSE)
	}
	
	margins.all <- c(
		margin.intersect(cols, col.margins, rows, row.margins),  
		margin.intersect(rows, row.margins, cols, col.margins)
	)

	if (grand.row && !is.null(rows)) margins.all <- compact(c(margins.all, list(cols), list(col.margins)))
	if (grand.col && !is.null(cols)) margins.all <- compact(c(margins.all, list(rows), list(row.margins)))
	
	if (
		(grand.col && grand.row && !is.null(rows) && !is.null(cols)) || 
		(grand.row && !is.null(rows) && is.null(cols)) || 
		(grand.col && !is.null(cols) && is.null(rows))
	) margins.all <- c(margins.all, list(numeric(0)))
	
	duplicates <- duplicated(lapply(lapply(margins.all,function(x) if(!is.null(x)) sort(x)), paste, collapse=""))
	
	margins.all[!duplicates]
}
