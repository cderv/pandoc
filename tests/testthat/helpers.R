skip_on_macos_arm <- function() {
  skip_if(
    pandoc_os() == "macOS" && pandoc_arch("macOS") == "arm64",
    "Skipping on MacOS ARM64"
  )
}
