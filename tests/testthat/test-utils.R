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

test_that("on_*() helpers works as expected", {
  withr::with_envvar(list(TESTTHAT = "true"), expect_true(on_testthat()))
  withr::with_envvar(list(TESTTHAT = NA), expect_false(on_testthat()))
  withr::with_envvar(list(CI = TRUE), expect_true(on_ci()))
  withr::with_envvar(list(CI = FALSE), expect_false(on_ci()))
  withr::with_envvar(list("_R_CHECK_PACKAGE_NAME_" = "pandoc"), expect_true(on_rcmd_check()))
  withr::with_envvar(list("_R_CHECK_PACKAGE_NAME_" = ""), expect_false(on_rcmd_check()))
})
