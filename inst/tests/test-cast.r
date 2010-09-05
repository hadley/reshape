context("cast")

s2 <- array(seq.int(3 * 4), c(3,4))
s2m <- melt(s2)
colnames(s2m) <- c("X1", "X2", "value")

s3 <- array(seq.int(3 * 4 * 5), c(3,4,5))
s3m <- melt(s3)
colnames(s3m) <- c("X1", "X2", "X3", "value")

test_that("reshaping matches t and aperm", {
  # 2d 
  expect_equivalent(s2, acast(s2m, X1 ~ X2))
  expect_equivalent(t(s2), acast(s2m, X2 ~ X1))
  expect_equivalent(as.vector(s2), as.vector(acast(s2m, X2 + X1 ~ .)))

  # 3d 
  expect_equivalent(s3, acast(s3m, X1 ~ X2 ~ X3))
  expect_equivalent(as.vector(s3), as.vector(acast(s3m, X3 + X2 + X1 ~ .)))
  expect_equivalent(aperm(s3, c(1,3,2)), acast(s3m, X1 ~ X3 ~ X2))
  expect_equivalent(aperm(s3, c(2,1,3)), acast(s3m, X2 ~ X1 ~ X3))
  expect_equivalent(aperm(s3, c(2,3,1)), acast(s3m, X2 ~ X3 ~ X1))
  expect_equivalent(aperm(s3, c(3,1,2)), acast(s3m, X3 ~ X1 ~ X2))
  expect_equivalent(aperm(s3, c(3,2,1)), acast(s3m, X3 ~ X2 ~ X1))
})

test_that("aggregation is matches apply", {

  # 2d -> 1d
  expect_equivalent(colMeans(s2), as.vector(acast(s2m, X2 ~ ., mean)))
  expect_equivalent(rowMeans(s2), as.vector(acast(s2m, X1 ~ ., mean)))
  
  # 3d -> 1d 
  expect_equivalent(apply(s3, 1, mean), as.vector(acast(s3m, X1 ~ ., mean)))
  expect_equivalent(apply(s3, 1, mean), as.vector(acast(s3m, . ~ X1, mean)))
  expect_equivalent(apply(s3, 2, mean), as.vector(acast(s3m, X2 ~ ., mean)))
  expect_equivalent(apply(s3, 3, mean), as.vector(acast(s3m, X3 ~ ., mean)))
  
  # 3d -> 2d
  expect_equivalent(apply(s3, c(1,2), mean), acast(s3m, X1 ~ X2, mean))
  expect_equivalent(apply(s3, c(1,3), mean), acast(s3m, X1 ~ X3, mean))
  expect_equivalent(apply(s3, c(2,3), mean), acast(s3m, X2 ~ X3, mean))
})

test_that("margins are computed correctly", {
  col <- acast(s2m, X1 ~ X2, mean, margins = "grand_col")[4, ]
  row <- acast(s2m, X1 ~ X2, mean, margins = "grand_row")[, 5]
  grand <- acast(s2m, X1 ~ X2, mean, margins = T)[4, 5]
  
  expect_equivalent(col, colMeans(s2))
  expect_equivalent(row, rowMeans(s2))
  expect_equivalent(grand, mean(s2))
  
})


test_that("missing combinations filled correctly", {
  s2am <- subset(s2m, !(X1 == 1 & X2 == 1))
  
  expect_equal(acast(s2am, X1 ~ X2)[1, 1], NA_integer_)
  expect_equal(acast(s2am, X1 ~ X2, length)[1, 1], 0)
  expect_equal(acast(s2am, X1 ~ X2, length, fill = 1)[1, 1], 1)
  
})