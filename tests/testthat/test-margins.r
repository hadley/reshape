vars <- list(c("a", "b", "c"), c("d", "e", "f"))
test_that("margins expanded", {
  expect_identical(margins(vars, "c")[[2]], c("c"))
  expect_identical(margins(vars, "b")[[2]], c("b", "c"))
  expect_identical(margins(vars, "a")[[2]], c("a", "b", "c"))

  expect_identical(margins(vars, "f")[[2]], c("f"))
  expect_identical(margins(vars, "e")[[2]], c("e", "f"))
  expect_identical(margins(vars, "d")[[2]], c("d", "e", "f"))
})

test_that("margins intersect", {
  expect_identical(margins(vars, c("c", "f"))[-1], list("c", "f", c("c", "f")))
})

test_that("(all) comes after NA", {
  df <- data.frame(a = c("a", "b", NA), b = c("a", "b", NA), value = 1)

  df2 <- add_margins(df, "a")
  expect_identical(levels(df2$a), c("a", "b", NA, "(all)"))

  df3 <- add_margins(df, c("a", "b"))
  expect_identical(levels(df3$a), c("a", "b", NA, "(all)"))
  expect_identical(levels(df3$b), c("a", "b", NA, "(all)"))

  dc <- dcast(df, a ~ ., margins = TRUE, fun = length)
  expect_identical(levels(dc$a), c("a", "b", NA, "(all)"))
  expect_identical(as.character(dc$a), c("a", "b", NA, "(all)"))

})
