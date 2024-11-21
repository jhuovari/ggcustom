# R/ggcustom_theme.R

#' Theme VM
#'
#' Theme VM. Based on \code{\link{theme_bw}}. geom defaults from \code{\link{vm_pal}}
#'
#' @param base_size a font size
#' @param base_family a font
#' @export
#' @examples
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p
#' p + theme_vm()

theme_vm <- function(base_size = 12, base_family = "") {
  # Set default colors for geoms using the first color in the VM palette
  ggplot2::update_geom_defaults("bar", list(fill = vm_pal(1)))
  ggplot2::update_geom_defaults("col", list(fill = vm_pal(1)))
  ggplot2::update_geom_defaults("point", list(size = 4, colour = vm_pal(1)))
  ggplot2::update_geom_defaults("text", list(size = 4, colour = vm_pal(1)))
  ggplot2::update_geom_defaults("line", list(linewidth = 1.5, colour = vm_pal(1)))

  # Apply the theme modifications
  ggplot2::theme_bw(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.margin = grid::unit(c(0.6, 0.7, 0.5, 0.6), "cm"),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
       strip.background = ggplot2::element_blank(),
      axis.line.x.bottom = ggplot2::element_line(),
      axis.line.x.top = ggplot2::element_line()
    )
}


#' Theme FPB
#'
#' Theme FPB. Based on \code{\link{theme_bw}}. geom defaults from \code{\link{fpb_pal}}
#'
#' @param base_size a font size
#' @param base_family a font
#' @export
#' @examples
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p
#' p + theme_fpb()

theme_fpb <- function(base_size = 12, base_family = "") {
  # Set default colors for geoms using the first color in the FPB palette
  ggplot2::update_geom_defaults("bar", list(fill = fpb_pal(1)))
  ggplot2::update_geom_defaults("col", list(fill = fpb_pal(1)))
  ggplot2::update_geom_defaults("point", list(size = 4, colour = fpb_pal(1)))
  ggplot2::update_geom_defaults("text", list(size = 4, colour = fpb_pal(1)))
  ggplot2::update_geom_defaults("line", list(linewidth = 1.5, colour = fpb_pal(1)))

  # Apply the theme modifications
  ggplot2::theme_bw(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.margin = grid::unit(c(0.6, 0.7, 0.5, 0.6), "cm"),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_rect(fill = NA, colour = "grey50", size = 1),
      panel.grid.major = ggplot2::element_line(colour = "grey90", size = 0.5),
      legend.text = ggplot2::element_text(size = ggplot2::rel(0.9)),
      axis.title = ggplot2::element_text(colour = "grey20", size = ggplot2::rel(0.8)),
      plot.subtitle = ggplot2::element_text(colour = "grey40"),
      plot.caption = ggplot2::element_text(size = ggplot2::rel(0.7), face = "plain", colour = "grey40"))

}
