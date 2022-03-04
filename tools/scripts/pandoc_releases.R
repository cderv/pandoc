# Check pandoc version file

devtools::load_all()
library(dplyr)
library(purrr)
library(tidyr)

releases <- pandoc_releases()
releases2 <- map(releases, "[[", c("tag_name"))

tab <- tibble(releases = releases) %>%
  hoist(
    releases,
    tag = "tag_name",
    name = "name",
    assets = "assets",
    html_url = "html_url"
  ) %>%
  unnest_longer(assets) %>%
  hoist(
    assets,
    name = "name",
    download_url = "browser_download_url"
  )

# some resources has no assets
tab %>% filter(is.na(name))
# tab %>% filter(is.na(name)) %>% slice(2) %>% pluck("html_url") %>% browseURL()
# tab %>% filter(is.na(name)) %>% slice(7) %>% pluck("html_url") %>% browseURL()

tab <- tab %>% filter(!is.na(name))

# extract file component
unique(tab$name)

extract_component <- function(name) {
  mat <- stringr::str_match_all(name, "pandoc-([0-9.]*[0-9]+)-?(?:\\d)?-?(?<os>[a-zA-Z]+)?-?.?(pkg|amd64|i386|x86_64|arm64)?\\.(deb|tar\\.gz|zip|pkg|msi|dmg)$")[[1]]
  mat <- mat[, -1]
  names(mat) <- c("version", "os", "arch", "ext")
  mat
}

tab <- tab %>%
  rowwise() %>%
  mutate(extract = list(extract_component(name))) %>%
  ungroup() %>%
  unnest_auto(extract)

# tag = version for all release !
tab %>%
  filter(tag != version)

# version as numeric value
tab <- tab %>%
  mutate(version = numeric_version(version))

# Github release since ?
tab %>% summarise(minmax = range(version))

#' ## WINDOWS

#' since 1.12
#'
# from which version zip are available compare to msi ?
tab %>%
  filter(ext == "msi") %>%
  summarise(minmax = range(version))

#' MSI since 1.12

tab %>%
  filter(ext == "zip", os == "windows") %>%
  summarise(minmax = range(version))

#' Zip are available since 2.0.2 only

#' ## LINUX
tab %>%
  filter(ext == "tar.gz") %>%
  summarise(minmax = range(version))
#' tar.gz available since pandoc 2.0

#' deb file are available since 1.13.2
tab %>%
  filter(ext == "deb") %>%
  summarise(minmax = range(version))

#' Linux was not available before that

#' ## MACOS
#' Zip file is provided in addition to .pkg file
tab %>%
  filter(ext == "zip", os == "macOS") %>%
  summarise(minmax = range(version))

#' it switches to macOS after that
tab %>%
  filter(os == "macOS", ext == "pkg") %>%
  summarise(minmax = range(version))

#' until 1.19.2.1, os was called osx
tab %>%
  filter(os == "osx", ext == "pkg") %>%
  summarise(minmax = range(version))

#' before 1.13, pkg for mac OS was a zip file
tab %>%
  filter(os == "osx", ext == "zip") %>%
  summarise(minmax = range(version))

#' and before that it was dmg file
tab %>%
  filter(is.na(os), ext == "dmg")

tab2 <- tab %>% select(-assets, -releases)

View(tab2)
