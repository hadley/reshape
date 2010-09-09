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

test_that("aggregation matches apply", {

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

names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE) 

test_that("aggregation matches table", {
  tab <- unclass(with(chick_m, table(chick, time)))
  cst <- acast(chick_m, chick ~ time, length)
  
  expect_that(tab, is_equivalent_to(cst))
})

test_that("grand margins are computed correctly", {
  col <- acast(s2m, X1 ~ X2, mean, margins = "X1")[4, ]
  row <- acast(s2m, X1 ~ X2, mean, margins = "X2")[, 5]
  grand <- acast(s2m, X1 ~ X2, mean, margins = T)[4, 5]
  
  expect_equivalent(col, colMeans(s2))
  expect_equivalent(row, rowMeans(s2))
  expect_equivalent(grand, mean(s2))
})
# 
test_that("internal margins are computed correctly", {
  cast <- dcast(chick_m, diet + chick ~ time, length, margins="diet")

  marg <- subset(cast, diet == "(all)")[-(1:2)]
  expect_that(as.vector(as.matrix(marg)), 
    equals(as.vector(acast(chick_m, time ~ ., length))))

  joint <- subset(cast, diet != "(all)")
  expect_that(joint, 
    is_equivalent_to(dcast(chick_m, diet + chick ~ time, length)))
})

test_that("missing combinations filled correctly", {
  s2am <- subset(s2m, !(X1 == 1 & X2 == 1))
  
  expect_equal(acast(s2am, X1 ~ X2)[1, 1], NA_integer_)
  expect_equal(acast(s2am, X1 ~ X2, length)[1, 1], 0)
  expect_equal(acast(s2am, X1 ~ X2, length, fill = 1)[1, 1], 1)
  
})

test_that("drop = FALSE generates all combinations", {
  df <- data.frame(x = c("a", "b"), y = c("a", "b"), value = 1:2)
  
  expect_that(as.vector(acast(df, x + y ~ ., drop = FALSE)),
    is_equivalent_to(as.vector(acast(df, x ~ y))))
  
})

test_that("aggregated values computed correctly", {
  ffm <- melt(french_fries, id = 1:4)
  
  count_c <- function(vars) as.table(acast(ffm, as.list(vars), length))
  count_t <- function(vars) table(ffm[vars], useNA = "ifany")
  
  combs <- matrix(names(ffm)[1:5][t(combn(5, 2))], ncol = 2)
  a_ply(combs, 1, function(vars) {
    expect_that(count_c(vars), is_equivalent_to(count_t(vars)), 
      label = paste(vars, collapse = ", "))
  })
  
})