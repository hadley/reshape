context("Margins")

vars <- list(c("a", "b", "c"), c("d", "e", "f"))
test_that("margins expanded", {  
  expect_that(margins(vars, "c")[[2]], equals(c("c")))
  expect_that(margins(vars, "b")[[2]], equals(c("b", "c")))
  expect_that(margins(vars, "a")[[2]], equals(c("a", "b", "c")))

  expect_that(margins(vars, "f")[[2]], equals(c("f")))
  expect_that(margins(vars, "e")[[2]], equals(c("e", "f")))
  expect_that(margins(vars, "d")[[2]], equals(c("d", "e", "f")))
})

test_that("margins intersect", {
  expect_that(margins(vars, c("c", "f"))[-1], 
    equals(list("c", "f", c("c", "f"))))
  
})