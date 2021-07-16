.get_assets_info <- function(os, arch) {
  map(pandoc_available_versions(), ~ {
    tryCatch(pandoc_release_asset(.x, os = os, arch = arch),
             error = function(e) list(version = .x, url = NULL, error = e$message))
  })
}

test_that("Assets are correctly found on windows", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("windows", "x86_64")
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux amd64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("linux", "amd64")
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux arm64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("linux", "arm64")
  errors <- keep(assets, ~ numeric_version(.x$version) <= "2.12")
  walk(errors, ~ {
    expect_match(.x$error, "available for 2.12 and above only", fixed = TRUE)
  })
  walk(discard(assets, ~ numeric_version(.x$version) <= "2.12"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Assets are correctly found on linux arm64", {
  skip_on_cran()
  skip_if_offline()
  assets <- .get_assets_info("macOS", NULL)
  pandoc_2.2.3 <- keep(assets, ~ .x$version == "2.2.3")[[1]]
  expect_match(pandoc_2.2.3$error, "regression")
  walk(discard(assets, ~ .x$version == "2.2.3"), ~ {
    asset_url <- .x[["url"]]
    expect_match(asset_url, "https://github.com/jgm/pandoc/releases/download", fixed = TRUE)
  })
})

test_that("Pandoc nightly can be installed", {
  skip_on_cran()
  skip_if_offline()
  install_dir <- pandoc_home_dir("nightly")
  if (!is.null(install_dir)) fs::dir_delete(install_dir)
  install_dir <- suppressMessages(pandoc_install("nightly"))
  bin <- paste0("pandoc", if (pandoc_os() == "windows") ".exe")
  expect_true(fs::file_exists(fs::path(install_dir, bin)))
})

test_that("Pandoc release can be installed", {
  skip_on_cran()
  skip_if_offline()
  install_dir <- pandoc_home_dir("2.11.4")
  if (!is.null(install_dir)) fs::dir_delete(install_dir)
  install_dir <- suppressMessages(pandoc_install("2.11.4"))
  bin <- paste0("pandoc", if (pandoc_os() == "windows") ".exe")
  expect_true(fs::file_exists(fs::path(install_dir, bin)))
  expect_message(expect_null(pandoc_install("2.11.4")), "already installed", fixed = TRUE)
  expect_identical(
    suppressMessages(pandoc_install("2.11.4", force = TRUE)),
    install_dir
  )
  expect_error(pandoc_install("2.2.3"))
})
