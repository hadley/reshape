s2 <- array(seq.int(3 * 4), c(3,4))
s2m <- melt(s2)
colnames(s2m) <- c("X1", "X2", "value")

s3 <- array(seq.int(3 * 4 * 5), c(3,4,5))
s3m <- melt(s3)
colnames(s3m) <- c("X1", "X2", "X3", "value")

test_that("reshaping matches t and aperm", {
  # 2d
  expect_identical(s2, acast(s2m, X1  ~  X2), ignore_attr = "dimnames")
  expect_identical(t(s2), acast(s2m, X2  ~  X1), ignore_attr = "dimnames")
  expect_identical(as.vector(s2), as.vector(acast(s2m, X2 + X1  ~  .)))

  # 3d
  expect_identical(s3, acast(s3m, X1  ~  X2  ~  X3), ignore_attr = "dimnames")
  expect_identical(as.vector(s3), as.vector(acast(s3m, X3 + X2 + X1  ~  .)))
  expect_identical(aperm(s3, c(1,3,2)), acast(s3m, X1  ~  X3  ~  X2), ignore_attr = "dimnames")
  expect_identical(aperm(s3, c(2,1,3)), acast(s3m, X2  ~  X1  ~  X3), ignore_attr = "dimnames")
  expect_identical(aperm(s3, c(2,3,1)), acast(s3m, X2  ~  X3  ~  X1), ignore_attr = "dimnames")
  expect_identical(aperm(s3, c(3,1,2)), acast(s3m, X3  ~  X1  ~  X2), ignore_attr = "dimnames")
  expect_identical(aperm(s3, c(3,2,1)), acast(s3m, X3  ~  X2  ~  X1), ignore_attr = "dimnames")
})

test_that("aggregation matches apply", {

  # 2d -> 1d
  expect_identical(colMeans(s2), as.vector(acast(s2m, X2  ~  ., mean)))
  expect_identical(rowMeans(s2), as.vector(acast(s2m, X1  ~  ., mean)))

  # 3d -> 1d
  expect_identical(apply(s3, 1, mean), as.vector(acast(s3m, X1  ~  ., mean)))
  expect_identical(apply(s3, 1, mean), as.vector(acast(s3m, .  ~  X1, mean)))
  expect_identical(apply(s3, 2, mean), as.vector(acast(s3m, X2  ~  ., mean)))
  expect_identical(apply(s3, 3, mean), as.vector(acast(s3m, X3  ~  ., mean)))

  # 3d -> 2d
  expect_identical(apply(s3, c(1,2), mean), acast(s3m, X1  ~  X2, mean), ignore_attr = "dimnames")
  expect_identical(apply(s3, c(1,3), mean), acast(s3m, X1  ~  X3, mean), ignore_attr = "dimnames")
  expect_identical(apply(s3, c(2,3), mean), acast(s3m, X2  ~  X3, mean), ignore_attr = "dimnames")
})

names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)

test_that("aggregation matches table", {
  tab <- unclass(with(chick_m, table(chick, time)))
  cst <- acast(chick_m, chick  ~  time, length)

  expect_identical(tab, cst, ignore_attr = "names")
})

test_that("grand margins are computed correctly", {
  col <- acast(s2m, X1  ~  X2, mean, margins = "X1")[4, ]
  row <- acast(s2m, X1  ~  X2, mean, margins = "X2")[, 5]
  grand <- acast(s2m, X1  ~  X2, mean, margins = TRUE)[4, 5]

  expect_identical(col, colMeans(s2), ignore_attr = "names")
  expect_identical(row, rowMeans(s2), ignore_attr = "names")
  expect_identical(grand, mean(s2))
})
#
test_that("internal margins are computed correctly", {
  cast <- dcast(chick_m, diet + chick  ~  time, length, margins="diet")

  marg <- subset(cast, diet == "(all)")[-(1:2)]
  expect_identical(
    as.vector(as.matrix(marg)),
    as.vector(acast(chick_m, time  ~  ., length))
  )

  joint <- subset(cast, diet != "(all)")
  joint$diet <- factor(joint$diet, levels = setdiff(levels(joint$diet), "(all)"))
  joint$chick <- factor(joint$chick, levels = setdiff(levels(joint$chick), "(all)"))
  expect_identical(joint, dcast(chick_m, diet + chick  ~  time, length))
})

test_that("missing combinations filled correctly", {
  s2am <- subset(s2m, !(X1 == 1 & X2 == 1))

  expect_equal(acast(s2am, X1  ~  X2)[1, 1], NA_integer_)
  expect_equal(acast(s2am, X1  ~  X2, length)[1, 1], 0)
  expect_equal(acast(s2am, X1  ~  X2, length, fill = 1)[1, 1], 1)

})

test_that("drop = FALSE generates all combinations", {
  df <- data.frame(x = c("a", "b"), y = c("a", "b"), value = 1:2)

  expect_identical(
    as.vector(acast(df, x + y  ~  ., drop = FALSE)),
    as.vector(acast(df, x  ~  y))
  )

})

test_that("aggregated values computed correctly", {
  ffm <- melt(french_fries, id = 1:4)

  count_c <- function(vars) as.table(acast(ffm, as.list(vars), length))
  count_t <- function(vars) table(ffm[vars], useNA = "ifany")

  combs <- matrix(names(ffm)[1:5][t(combn(5, 2))], ncol = 2)
  a_ply(combs, 1, function(vars) {
    expect_identical(
      count_c(vars),
      count_t(vars),
      label = toString(vars),
      ignore_attr = "names"
    )
  })

})

test_that("value.var overrides value col", {
  df <- data.frame(
    id1 = rep(letters[1:2],2),
    id2 = rep(LETTERS[1:2],each=2), var1=1:4)

  expect_message({
    df.m <- melt(df)
  }, "Using id1, id2 as id variables", fixed = TRUE)
  df.m$value2 <- df.m$value * 2
  expect_identical(acast(df.m, id2 + id1  ~  ., value.var="value")[, 1], 1:4, ignore_attr = "names")
  expect_identical(acast(df.m, id2 + id1  ~  ., value.var="value2")[, 1], 2 * 1:4, ignore_attr = "names")
})

test_that("labels are correct when missing combinations dropped/kept", {
  df <- data.frame(fac1 = letters[1:4], fac2 = LETTERS[1:4], x = 1:4, stringsAsFactors = TRUE)
  mx <- melt(df, id = c("fac1", "fac2"), measure.var = "x")

  c1 <- dcast(mx[1:2, ], fac1 + fac2 ~ variable, length, drop = F)
  expect_identical(nrow(c1), 16L)

  c2 <- dcast(droplevels(mx[1:2, ]), fac1 + fac2 ~ variable, length, drop = F)
  expect_identical(nrow(c2), 4L)

  c3 <- dcast(mx[1:2, ], fac1 + fac2 ~ variable, length, drop = T)
  expect_identical(nrow(c3), 2L)
})

test_that("factor value columns are handled", {
  df <- data.frame(fac1 = letters[1:4], fac2 = LETTERS[1:4], x = factor(1:4))
  mx <- melt(df, id = c("fac1", "fac2"), measure.var = "x")

  c1 <- dcast(mx, fac1 + fac2 ~ variable)
  expect_identical(nrow(c1), 4L)
  expect_identical(ncol(c1), 3L)
  expect_type(c1$x, "character")

  c2 <- dcast(mx, fac1 ~ fac2 + variable)
  expect_identical(nrow(c2), 4L)
  expect_identical(ncol(c2), 5L)
  expect_type(c2$A_x, "character")
  expect_type(c2$B_x, "character")
  expect_type(c2$C_x, "character")
  expect_type(c2$D_x, "character")

  c3 <- acast(mx, fac1 + fac2 ~ variable)
  expect_identical(nrow(c3), 4L)
  expect_identical(ncol(c3), 1L)
  expect_true(is.character(c3))

  c4 <- acast(mx, fac1 ~ fac2 + variable)
  expect_identical(nrow(c4), 4L)
  expect_identical(ncol(c4), 4L)
  expect_true(is.character(c4))

})

test_that("dcast evaluated in correct argument", {
  g <- c("a", "b")
  expr <- quote({
    df <- data.frame(x = letters[1:2], y = letters[1:3], z = rnorm(6))
    g <- c('b', 'a')
    dcast(df, y ~ ordered(x, levels = g))
  })

  expect_message(
    expect_named(eval(expr, envir = new.env()), c("y", "b", "a")),
    "Using z as value column", fixed = TRUE
  )

})

test_that(". ~ . returns single value", {
  one <- acast(s2m, . ~ .,  sum)
  expect_equal(as.vector(one), 78)
  expect_equal(dimnames(one), list(".", "."))
})

test_that("drop = TRUE retains NA values", {
  df <- data.frame(x = 1:5, y = c(letters[1:4], NA), value = 5:1)
  out <- dcast(df, x + y ~ .)

  expect_equal(dim(out), c(5, 3))
  expect_equal(out$., 5:1)
})

test_that("useful error message if you use value_var", {
  expect_error(dcast(mtcars, vs ~ am, value_var = "cyl"),
    "Please use value.var", fixed = TRUE)
  expect_message(
    expect_equal(dim(dcast(mtcars, vs ~ am, value.var = "cyl")), c(2, 3)),
    "Aggregation function missing", fixed = TRUE
  )

})

test_that("useful error message if value.var doesn't exist", {
  expect_error(dcast(airquality, month ~ day, value.var = "test"),
    "value.var (test) not found in input", fixed = TRUE)
})
