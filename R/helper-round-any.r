# Round any
# Round to multiple of any number
# 
# Useful when you want to round a number to arbitrary precision
# 
# @arguments numeric vector to round
# @arguments number to round to
# @arguments function to use for round (eg. \code{\link{floor}})
# @keyword internal 
#X round_any(135, 10)
#X round_any(135, 100)
#X round_any(135, 25)
#X round_any(135, 10, floor)
#X round_any(135, 100, floor)
#X round_any(135, 25, floor)
#X round_any(135, 10, ceiling)
#X round_any(135, 100, ceiling)
#X round_any(135, 25, ceiling)
round_any <- function(x, accuracy, f=round) {
  f(x / accuracy) * accuracy
}