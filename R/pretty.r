# Pretty print
# Print reshaped data frame
#
# This will always work on the direct output from cast, but may not
# if you have manipulated (e.g. subsetted) the results.
# 
# @argument Reshaped data frame
# @argument Argument required to match generic
# @argument Argument required to match generic
# @keyword internal
prettyprint <- function(x, digits=getOption("digits"), ..., colnames=TRUE) {
  unx <- x
  class(unx) <- "data.frame"
  label.rows <- names(rrownames(x))
  
  labels <- strip.dups(unx[,names(x) %in% label.rows, drop=FALSE])
  colnames(labels) <- label.rows[names(x) %in% label.rows]
  data <-   as.matrix((unx[,!(names(x) %in% label.rows), drop=FALSE]))
  
  col.labels <- t(strip.dups(rcolnames(x)))
  
  bottom <- cbind(labels,data)
  top <- cbind(matrix("", ncol=ncol(labels)-1, nrow=nrow(col.labels)), names(rcolnames(x)), col.labels)
  if(colnames) {
    middle <- colnames(bottom)
  } else {
    middle <- c(colnames(labels), rep("", ncol(bottom) - length(colnames(labels))))
  }

  result <- rbind(top, middle, bottom)
  rownames(result) <- rep("", nrow(result))
  colnames(result) <- rep("", ncol(result))

  print(result, quote=FALSE, right=TRUE)  
}

# Strip duplicates.
# Strips out duplicates from data.frame and replace them with blanks.
# 
# @arguments data.frame to modify
# @value character matrix
# @keyword internal
strip.dups <- function(df) {
  clear.dup <- function(dups,ret=dups) ifelse(duplicated(dups), "", ret)

  mat <- apply(df, c(1,2), as.character)
  do.call(cbind, lapply(1:ncol(mat), function(x) clear.dup(mat[,1:x, drop=FALSE], mat[,x, drop=FALSE])))
}
