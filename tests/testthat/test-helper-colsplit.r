test_that("colsplit works", {
  x <- c("a_1", "a_2", "b_2", "c_3")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", "c"), time = c(1L, 2L, 2L, 3L))
  )

  x <- c("a_1", "a_2", "b_2", "c_")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", "c"), time = c(1L, 2L, 2L, NA))
  )

  x <- c("a_1", "a_2", "b_2", "c")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", "c"), time = c(1L, 2L, 2L, NA))
  )

  x <- c("a", "a", "b", "c")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", "c"), time = NA)
  )

  x <- c("a_1", "a_2", "b_2", NA)
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", NA), time = c(1L, 2L, 2L, NA))
  )

  x <- c("a_1", "a_2", "b_2", "c_3_4")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c("a", "a", "b", "c"), time = c("1", "2", "2", "3_4"))
  )

  x <- c("TRUE_1", "TRUE_2", "TRUE_2", "FALSE_3")
  expect_identical(
    colsplit(x, "_", c("trt", "time")),
    data.frame(trt = c(TRUE, TRUE, TRUE, FALSE), time = c(1L, 2L, 2L, 3L))
  )
})
