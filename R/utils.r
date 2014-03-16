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
