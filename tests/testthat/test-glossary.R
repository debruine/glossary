test_that("errors", {
  expect_error(glossary(path = NULL))
  expect_warning(glossary("hi"))
})

test_that("no path", {
  glossary_reset()
  glossary_options(path = NULL)

  test <- glossary("hi")
  exp <- "<a class='glossary' title=''>hi</a>"
  expect_equal(test, exp)

  # added to table
  test <- glossary_options("table")
  exp <- list(hi = "")
  expect_equal(test, exp)

  # set def inline
  test <- glossary("hi", def = "greeting")
  exp <- "<a class='glossary' title='greeting'>hi</a>"
  expect_equal(test, exp)

  # definition updated
  test <- glossary_options("table")
  exp <- list(hi = "greeting")
  expect_equal(test, exp)

  test <- glossary("hi", def = "greeting", show_def = TRUE)
  exp <- "greeting"
  expect_equal(test, exp)

  # different display
  test <- glossary("lo", def = "direction", display = "LO")
  exp <- "<a class='glossary' title='direction'>LO</a>"
  expect_equal(test, exp)

  # don't add to table
  glossary("no", add_to_table = FALSE)
  test <- glossary_options("table")
  exp <- list(hi = "greeting", lo = "direction")
  expect_equal(test, exp)
})


test_that("no path", {
  glossary_reset()

  # set up path to example glossary file
  path <- system.file("glossary.yml", package = "glossary")
  glossary_options(path = path)

  # basic
  test <- glossary("alpha")
  exp <- "<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% it most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.\n'>alpha</a>"
  expect_equal(test, exp)

  # non-matching case
  test <- glossary("Alpha")
  exp <- "<a class='glossary' title='The threshold chosen in Neyman-Pearson hypothesis testing to distinguish test results that lead to the decision to reject the null hypothesis, or not, based on the desired upper bound of the Type 1 error rate. An alpha level of 5% it most commonly used, but other alpha levels can be used as long as they are determined and preregistered by the researcher before the data is analyzed.\n'>Alpha</a>"
  expect_equal(test, exp)

})
