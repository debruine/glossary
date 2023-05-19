test_that("add to table", {
  glossary_reset()

  glossary("hi", def = "geeting", path = NULL)

  test <- glossary_options("table")
  exp <- list(hi = "greeting")
  expect_equal(test, exp)
})
