# Package index

## Install & Manage Pandoc with this package

### Install / Update / Uninstall Pandoc

- [`pandoc_install()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  [`pandoc_update()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  [`pandoc_install_nightly()`](https://cderv.github.io/pandoc/dev/reference/pandoc_install.md)
  : Install a pandoc binary for Github release page
- [`pandoc_installed_versions()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  [`pandoc_installed_latest()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  [`pandoc_is_installed()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  : Check Pandoc versions already installed
- [`pandoc_uninstall()`](https://cderv.github.io/pandoc/dev/reference/pandoc_uninstall.md)
  : Uninstall a Pandoc version
- [`pandoc_available_releases()`](https://cderv.github.io/pandoc/dev/reference/pandoc_available_releases.md)
  : Fetch all versions available to install

### Manage versions installed by this package

Functions to find an installed version by this package

- [`pandoc_installed_versions()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  [`pandoc_installed_latest()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  [`pandoc_is_installed()`](https://cderv.github.io/pandoc/dev/reference/pandoc_installed_versions.md)
  : Check Pandoc versions already installed
- [`pandoc_locate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_locate.md)
  : Locate a specific Pandoc version installed with this package

## Get path to any pandoc binary

Functions to access pandoc binary path, including external ones.

- [`pandoc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)
  [`pandoc_bin_browse()`](https://cderv.github.io/pandoc/dev/reference/pandoc_bin.md)
  : Get path to the pandoc binary
- [`pandoc_citeproc_bin()`](https://cderv.github.io/pandoc/dev/reference/pandoc_citeproc_bin.md)
  : Get path to the pandoc-citeproc binary.
- [`pandoc_quarto_version()`](https://cderv.github.io/pandoc/dev/reference/quarto_pandoc.md)
  [`pandoc_quarto_bin()`](https://cderv.github.io/pandoc/dev/reference/quarto_pandoc.md)
  : Retrieve path and version of Pandoc shipped with Quarto CLI
- [`pandoc_rstudio_version()`](https://cderv.github.io/pandoc/dev/reference/rstudio_pandoc.md)
  [`pandoc_rstudio_bin()`](https://cderv.github.io/pandoc/dev/reference/rstudio_pandoc.md)
  : Retrieve path and version of Pandoc shipped with RStudio
- [`pandoc_system_version()`](https://cderv.github.io/pandoc/dev/reference/system_pandoc.md)
  [`pandoc_system_bin()`](https://cderv.github.io/pandoc/dev/reference/system_pandoc.md)
  : Retrieve path and version of Pandoc found on the system PATH

## Handle Pandoc version

### Activate a pandoc version

Function to change active default version of Pandoc used

- [`pandoc_activate()`](https://cderv.github.io/pandoc/dev/reference/pandoc_activate.md)
  : Activate a specific Pandoc version to be used
- [`with_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
  [`local_pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/with_pandoc_version.md)
  : Execute any code with a specific Pandoc version

### Check pandoc (active) version

- [`pandoc_is_active()`](https://cderv.github.io/pandoc/dev/reference/pandoc_is_active.md)
  : Is a pandoc version active ?
- [`pandoc_available()`](https://cderv.github.io/pandoc/dev/reference/pandoc_available.md)
  : Check if active Pandoc version meet a requirement
- [`pandoc_version()`](https://cderv.github.io/pandoc/dev/reference/pandoc_version.md)
  : Get Pandoc version

## Run pandoc binary

- [`pandoc_run()`](https://cderv.github.io/pandoc/dev/reference/pandoc_run.md)
  : Run the pandoc binary from R
- [`pandoc_convert()`](https://cderv.github.io/pandoc/dev/reference/pandoc_convert.md)
  : Run Pandoc to convert a document or a text

### List some informations built-in Pandoc binary

Functions to access from R information usually accessible by command
line only

- [`pandoc_list_abbreviations()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_abbreviations.md)
  : List system default abbreviations
- [`pandoc_list_extensions()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_extensions.md)
  : List supported extensions for a format
- [`pandoc_list_formats()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_formats.md)
  : List available supported formats
- [`pandoc_list_highlight_languages()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_highlight_languages.md)
  : List supported languages for Pandoc syntax highlighting
- [`pandoc_list_highlight_style()`](https://cderv.github.io/pandoc/dev/reference/pandoc_list_highlight_style.md)
  : List supported styles for Pandoc syntax highlighting

### Export templates and other file content built-in Pandoc binary

Functions to export to file templates, reference doc and other data file

- [`pandoc_export_data_file()`](https://cderv.github.io/pandoc/dev/reference/pandoc_export_data_file.md)
  [`pandoc_export_reference_doc()`](https://cderv.github.io/pandoc/dev/reference/pandoc_export_data_file.md)
  : Export Pandoc internal data file
- [`pandoc_export_highlight_theme()`](https://cderv.github.io/pandoc/dev/reference/pandoc_export_highlight_theme.md)
  : Export highlighting style as JSON file
- [`pandoc_export_template()`](https://cderv.github.io/pandoc/dev/reference/pandoc_export_template.md)
  : Retrieve Pandoc template for a format

## Browse Pandoc’s useful online resources

Functions for quickly accessing relevant online resources.

- [`pandoc_browse_citation()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_citation.md)
  : Open Pandoc's documentation about citation processing
- [`pandoc_browse_exit_code()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_exit_code.md)
  : Open Pandoc's documentation about exit codes
- [`pandoc_browse_extension()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_extension.md)
  : Open Pandoc's documentation about an extension
- [`pandoc_browse_manual()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_manual.md)
  : Open Pandoc's MANUAL
- [`pandoc_browse_option()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_option.md)
  : Open Pandoc's documentation about a command line option
- [`pandoc_browse_release()`](https://cderv.github.io/pandoc/dev/reference/pandoc_browse_release.md)
  : Open Pandoc's release page in browser
