test_that("resolve_version()", {
  rlang::local_bindings(active_version = "nightly", .env = the)
  expect_equal(resolve_version("default"), "nightly")
  expect_equal(resolve_version("2.11.4"), "2.11.4")
  expect_equal(resolve_version("latest"), pandoc_installed_latest())
})
