% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pandoc-list.R
\name{pandoc_list_highlight_languages}
\alias{pandoc_list_highlight_languages}
\title{List supported languages for Pandoc syntax highlighting}
\usage{
pandoc_list_highlight_languages(version = "default")
}
\arguments{
\item{version}{Version to use. Default will be the \code{"default"} version. Other possible value are
\itemize{
\item A version number e.g \code{"2.14.1"}
\item The nightly version called \code{"nightly"}
\item The latest installed version with \code{"latest"}
\item Pandoc binary shipped with RStudio IDE with \code{"rstudio"}
\item Pandoc binary found in PATH with \code{"system"}
}}
}
\value{
a character vector of supported languages to use as fenced code
attributes.
}
\description{
This function is useful to retrieve the supported languages by Pandoc's
syntax highlighter. These are the values that can be used as fenced code
attributes to trigger the highlighting of the block for the requested
language. See \href{https://pandoc.org/MANUAL.html#extension-fenced_code_attributes}{\code{fenced_code_attributes} extensions flag}.
}
\examples{
\dontshow{if (pandoc::pandoc_available("2.0")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
pandoc_list_highlight_languages()
\dontshow{\}) # examplesIf}
\dontshow{if (pandoc::pandoc_is_installed("2.11.4")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# check languages available in a specific Pandoc's version
pandoc_list_highlight_languages("2.11.4")
\dontshow{\}) # examplesIf}
}
