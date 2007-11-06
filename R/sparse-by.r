# a version of by for cases where the dataset doesn't cross all the variables
# based on an idea by Hadley Wickham

# This function assumes that the data is in a matrix or data.frame, and returns data in a
# matrix or data frame.  It tries not to turn matrices into data frames except when necessary.

# It should be possible to parallelize it....

sparseby <- function (data, INDICES = list(), FUN, ..., GROUPNAMES = TRUE) {
   cbind2 <- function (...) {
       if (all(lapply(list(...), is.numeric))) cbind(...)
       else do.call("cbind.data.frame", list(...))
   }
   if (is.list(INDICES)) IND <- do.call("cbind2", INDICES)
   else if (is.null(dim(INDICES)) || length(dim(INDICES)) < 2) {
       IND <- matrix(INDICES, ncol = 1, dimnames = list(NULL, deparse(substitute(INDICES))))
   } else if (length(dim(INDICES)) > 2) stop("Cannot handle multi-dimensional indices")
   else IND = INDICES

   if (nrow(IND) == 0 ) {
       result <- rbind(FUN(data, ...))
   } else {
       ncols <- function (x) {
           if (is.matrix(x) || is.data.frame(x)) return(ncol(x))
           else return(length(x))
       }

       if (length(colnames(IND)) == 0) colnames(IND) <- rep("", ncols(IND))

       colnames(IND) <- ifelse(colnames(IND) == "", paste("V", 1:ncols(IND), sep=""),
                                                          colnames(IND))

       o <- do.call("order", as.data.frame(IND))
       keys <- IND[o,,drop=FALSE]
       df <- data[o,,drop=FALSE]

#       duplicates <- duplicated(keys)

#       Faster way, since we know the keys are sorted:
       duplicates <- c(FALSE,apply(keys[1:(nrow(keys)-1),,drop=FALSE] != keys[2:nrow(keys),,drop=FALSE],1,sum) == 0)

       index <- cumsum(!duplicates)

       FUNx <- function (x) FUN(df[x,,drop=FALSE], ...)

       result <- tapply(1:nrow(df), index, FUNx, simplify=FALSE)

       # Drop NULLs from results

       nulls <- unlist(lapply(result, is.null))
       result <- result[!nulls]
       if (length(result) == 0) return(NULL)

       lens <- range(lapply(result, ncols))
       if (lens[1] != lens[2]) stop("function returns inconsistent lengths")
       if (GROUPNAMES) {
           keys[index,] <- keys
           keys <- keys[(1:length(nulls))[!nulls],,drop=FALSE]
           if (all(lapply(result, function(x) length(dim(x)) == 2)))
               keys <- keys[rep(1:length(result), lapply(result, nrow)),,drop=FALSE]
           else
               keys <- keys[(1:length(result)),,drop=FALSE]
       }
       result <- do.call("rbind", result)
       if (GROUPNAMES) result <- cbind2(keys, result)
   }
   return(result)
}

