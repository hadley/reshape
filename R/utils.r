"%||%" <- function(a, b) if (!is.null(a)) a else b

all_identical <- function(xs) {
  if (length(xs) <= 1) return(TRUE)
  for (i in seq(2, length(xs))) {
    if (!identical(xs[[1]], xs[[i]])) return(FALSE)
  }
  TRUE
}

## Get the attributes if common, NULL if not.
normalize_melt_arguments <- function(data, measure.ind, factorsAsStrings) {

  measure.attributes <- lapply(measure.ind, function(i) {
    attributes(data[[i]])
  })

  ## Determine if all measure.attributes are equal
  measure.attrs.equal <- all_identical(measure.attributes)

  if (measure.attrs.equal) {
    measure.attributes <- measure.attributes[[1]]
  } else {
    warning("attributes are not identical across measure variables; ",
      "they will be dropped", call. = FALSE)
    measure.attributes <- NULL
  }

  if (!factorsAsStrings && !measure.attrs.equal) {
    warning("cannot avoid coercion of factors when measure attributes not identical",
      call. = FALSE)
    factorsAsStrings <- TRUE
  }

  ## If we are going to be coercing any factors to strings, we don't want to
  ## copy the attributes
  any.factors <- any( sapply( measure.ind, function(i) {
    is.factor( data[[i]] )
  }))

  if (factorsAsStrings && any.factors) {
    measure.attributes <- NULL
  }

  list(
    measure.attributes = measure.attributes,
    factorsAsStrings = factorsAsStrings
  )

}

is.string <- function(x) {
  is.character(x) && length(x) == 1
}

# base-only drop-in for rbind.fill()
bind_rows <- function(dfs) {
  df_sizes <- lengths(dfs)
  if (length(unique(df_sizes)) > 1L) {
    # NB: rbind() _does_ use name matching for columns, so we don't need to
    #   reorder all the ourselves.
    out_names <- character()
    for (df in dfs) {
      out_names <- c(out_names, setdiff(names(df), out_names))
    }
    # for (df in dfs) doesn't work; 'df' gets copy-on-written.
    for (ii in seq_along(dfs)) {
      dfs[[ii]][setdiff(out_names, names(dfs[[ii]]))] <- NA
    }
  }
  do.call(rbind, dfs)
}
