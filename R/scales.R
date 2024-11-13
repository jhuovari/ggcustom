# R/scales.R

#' VM Color and Fill Scale
#'
#' Discrete VM color scale. Colors from \code{\link{vm_pal}}.
#'
#' @param ... Other arguments passed on to \code{\link{discrete_scale}}.
#' @export
#' @examples
#'  library(ggplot2)
#'  dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
#'  (d <- ggplot(dsamp, aes(carat, price, colour = clarity)) + geom_point())
#'
#'  d + scale_colour_vm()

scale_fill_vm <- function(...) {
  ggplot2::discrete_scale("fill", "vm", vm_pal, ...)
}

#' @rdname scale_fill_vm
#' @export
scale_colour_vm <- function(...) {
  ggplot2::discrete_scale("colour", "vm", vm_pal, ...)
}

#' @rdname scale_fill_vm
#' @export
scale_color_vm <- function(...) {
  ggplot2::discrete_scale("colour", "vm", vm_pal, ...)
}

#' @rdname scale_fill_vm
#' @export
scale_colour_vm_lg <- function(...) {
  ggplot2::discrete_scale("colour", "vm_lg", vm_pal_lg, ...)
}

#' @rdname scale_fill_vm
#' @export
scale_color_vm_lg <- function(...) {
  ggplot2::discrete_scale("colour", "vm_lg", vm_pal_lg, ...)
}
