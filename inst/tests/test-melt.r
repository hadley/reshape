context("Melt")

test_that("Missing values removed when na.rm = TRUE", {
  v <- c(1:3, NA)
  expect_equal(melt(v)$value, v)
  expect_equal(melt(v, na.rm = TRUE)$value, 1:3)

  m <- matrix(v, nrow = 2)
  expect_equal(melt(m)$value, v)
  expect_equal(melt(m, na.rm = TRUE)$value, 1:3)

  l1 <- list(v)
  expect_equal(melt(l1)$value, v)
  expect_equal(melt(l1, na.rm = TRUE)$value, 1:3)

  l2 <- as.list(v)
  expect_equal(melt(l2)$value, v)
  expect_equal(melt(l2, na.rm = TRUE)$value, 1:3)

  df <- data.frame(x = v)
  expect_equal(melt(df)$value, v)
  expect_equal(melt(df, na.rm = TRUE)$value, 1:3)
})

test_that("value col name set by value.name", {
  v <- c(1:3, NA)
  expect_equal(names(melt(v, value.name = "v")), "v")

  m <- matrix(v, nrow = 2)
  expect_equal(names(melt(m, value.name = "v"))[3], "v")

  l1 <- list(v)
  expect_equal(names(melt(l1, value.name = "v"))[1], "v")

  df <- data.frame(x = v)
  expect_equal(names(melt(df, value.name = "v"))[2], "v")
})

test_that("lists can have zero element components", {
  l <- list(a = 1:10, b = integer(0))
  m <- melt(l)

  expect_equal(nrow(m), 10)
})

test_that("factors coerced to characters, not integers", {
  df <- data.frame(
    id = 1:3,
    v1 = 1:3,
    v2 = factor(letters[1:3]))
  expect_warning(dfm <- melt(df, 1))

  expect_equal(dfm$value, c(1:3, letters[1:3]))
})

test_that("dimnames are preserved with arrays and tables", {
  a <- array(c(1:12), c(2,3,2))

  # Plain array with no dimnames
  am <- melt(a)
  expect_equal(names(am), c("Var1", "Var2", "Var3", "value"))
  # Also check values
  expect_equal(unique(am$Var1), 1:2)
  expect_equal(unique(am$Var2), 1:3)
  expect_equal(unique(am$Var3), 1:2)

  # Explicitly set varnames
  am <- melt(a, varnames = c("X", "Y", "Z"))
  expect_equal(names(am), c("X", "Y", "Z", "value"))

  # Set the dimnames for the array
  b <- a
  dimnames(b) <- list(X = c("A", "B"), Y = c("A", "B", "C"), Z = c("A", "B"))
  bm <- melt(b)
  expect_equal(names(bm), c("X", "Y", "Z", "value"))
  # Also check values
  expect_equal(levels(bm$X), c("A", "B"))
  expect_equal(levels(bm$Y), c("A", "B", "C"))
  expect_equal(levels(bm$Z), c("A", "B"))

  # Make sure the same works for contingency tables
  b <- as.table(a)
  dimnames(b) <- list(X = c("A", "B"), Y = c("A", "B", "C"), Z = c("A", "B"))
  bm <- melt(b)
  expect_equal(names(bm), c("X", "Y", "Z", "value"))
  # Also check values
  expect_equal(levels(bm$X), c("A", "B"))
  expect_equal(levels(bm$Y), c("A", "B", "C"))
  expect_equal(levels(bm$Z), c("A", "B"))
})

test_that("as.is = TRUE suppresses dimnname conversion", {
  x <- matrix(nrow = 2, ncol = 2)
  dimnames(x) <- list(x = 1:2, y = 3:4)

  out <- melt(x, as.is = TRUE)
  expect_true(is.character(out$x))
  expect_true(is.character(out$y))

})

test_that("The 'variable' column is a factor after melting a data.frame", {
  df <- data.frame(x=1:3, y=4:6)
  df.m <- melt(df)
  expect_true( is.factor(df.m$variable) )
})

test_that("Common classes are preserved in measure variables", {
  df <- data.frame(id = 1:2, date1 = Sys.Date(), date2 = Sys.Date() + 10)
  m <- melt(df, measure.vars=c("date1", "date2"))
  expect_true( class(m$value) == "Date" )
})

test_that("Common attributes are preserved in measure variables", {
  df <- data.frame(
    id = 1:2,
    date1 = as.POSIXct( Sys.Date() ),
    date2 = as.POSIXct( Sys.Date() + 10)
  )
  m <- melt(df, measure.vars=c("date1", "date2"))
})

test_that("A warning is thrown when attributes are dropped in measure variables", {
  df <- data.frame(
    id=1:2,
    date1 = as.POSIXct( Sys.Date() ),
    date2 = Sys.Date() + 10
  )
  expect_warning( melt(df, measure.vars=c("date1", "date2")) )
})
