test_that("resolve_version()", {
  rlang::local_bindings(active_version = "nightly", .env = the)
  expect_equal(resolve_version("default"), "nightly")
  expect_equal(resolve_version("2.11.4"), "2.11.4")
  expect_equal(resolve_version("latest"), pandoc_installed_latest())
})

test_that("pandoc_feature_requirement() not met", {
  skip_on_cran()
  skip_if_offline()
  suppressMessages(pandoc_install("2.11.4"))
  expect_true(pandoc_feature_requirement("2.8", version = "2.11.4"))
  expect_error(pandoc_feature_requirement("2.12", version = "2.11.4"), "`2.12` and above", fixed = TRUE)
})
