% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/palettes.R
\name{fpb_pal}
\alias{fpb_pal}
\alias{fpb_pal_lg}
\title{Finnish Productivity Board Color Palette}
\usage{
fpb_pal(n = NULL)

fpb_pal_lg(n = NULL)
}
\arguments{
\item{n}{A number of colors needed.}
}
\description{
Color palette for Finnish Productivity Board (discrete).
}
\details{
Provides the VM color palette with colors recycled if needed (with warning).
}
\section{Functions}{
\itemize{
\item \code{fpb_pal_lg()}: Finnish Productivity Board palette with the last color grey.

}}
\examples{
scales::show_col(vm_pal(6))
}
