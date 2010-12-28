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