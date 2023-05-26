test_that("add to table", {
  glossary_reset()

  glossary("hi", def = "greeting", path = NULL)

  test <- glossary_options("table")
  exp <- list(hi = "greeting")
  expect_equal(test, exp)

  tbl <- glossary_table()
  expect_equal(class(tbl), c("kableExtra", "knitr_kable"))

  df <- glossary_table(as_kable = FALSE)
  exp <- data.frame(
    term = "hi",
    definition = "greeting",
    row.names = "hi")
  expect_equal(exp, df)
})

test_that("psyteachr", {
  skip_if_offline("psyteachr.github.io")
  glossary_reset()
  glossary_path("psyteachr")

  glossary("script")

  tbl <- glossary_table()
  has_link <- grepl("<a href=\"https://psyteachr.github.io/glossary/s#script\" target=\"_blank\">script</a>", tbl)
  expect_true(has_link)

  df <- glossary_table(FALSE)
  exp <- data.frame(
    term = "script",
    definition = "A plain-text file that contains commands in a coding language, such as R.",
    row.names = "script")
  expect_equal(exp, df)
})
