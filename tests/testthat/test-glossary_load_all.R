path <- system.file("glossary.yml", package = "glossary")

test_that("exists, default", {
  expect_type(glossary_load_all, "closure")
  glossary_reset()
  glossary_path(path)

  glossary_load_all()
  tbl <- glossary_options("table")
  expect_equal(names(tbl), c("alpha", "alpha (graphics)", "p-value",
                             "effect size", "power", "SESOI", "html"))
})

test_that("specify path", {
  glossary_reset()
  glossary_path("psyteachr")

  expect_error(glossary_load_all(), "Cannot load all from the psyteachr glossary, please specify a path to a YAML glossary file")
  expect_error(glossary_load_all("x"), "The file x does not exist")
  glossary_load_all(path)
  tbl <- glossary_options("table")
  expect_equal(names(tbl), c("alpha", "alpha (graphics)", "p-value",
                             "effect size", "power", "SESOI", "html"))
})

test_that("pre-existing definition", {
  glossary_reset()
  path <- system.file("glossary.yml", package = "glossary")
  glossary_path(path)
  sink <- glossary("power", def = "TESTING")

  tbl <- glossary_options("table")
  expect_equal(tbl$power, "TESTING")

  # should overwrite power
  glossary_load_all(path)
  tbl2 <- glossary_options("table")
  expect_equal(tbl2$power, "The probability of rejecting the null hypothesis when it is false, for a specific analysis, effect size, sample size, and criteria for significance.")
})
