# R/ggcustom_theme.R

#' Theme VM
#'
#' Theme VM. Based on \code{\link[ggplot2]{theme_bw}}. Sets discrete colour
#' and fill palette defaults to \code{\link{vm_pal}} via ggplot2 4.0.0 theme
#' entries, and sets the default fill/colour and size of layer geoms (bar,
#' col, point, text, line) to match the VM palette via the `geom` theme
#' entry introduced in ggplot2 4.0.0 (\code{\link[ggplot2]{element_geom}}) -
#' no \code{update_geom_defaults()} side effect.
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
  # Apply the theme modifications
  ggplot2::theme_bw(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.margin = grid::unit(c(0.6, 0.7, 0.5, 0.6), "cm"),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      strip.background = ggplot2::element_blank(),
      axis.line.x.bottom = ggplot2::element_line(),
      axis.line.x.top = ggplot2::element_line(),
      # Default fill/colour/size for layer geoms, sourced from the theme
      # itself (ggplot2 4.0.0) instead of a global update_geom_defaults()
      # side effect. Matches the previous bar/col fill, point/text/line
      # colour = vm_pal(1), point/text size = 4, line linewidth = 1.5.
      geom = ggplot2::element_geom(
        colour = vm_pal(1),
        fill = vm_pal(1),
        linewidth = 1.5,
        pointsize = 4,
        fontsize = 4
      ),
      # A single-argument closure with no default for `n`: passing vm_pal
      # itself (whose no-argument form defaults n to NULL, to return the
      # full palette) makes ggplot2's theme palette entry raise "has NULL
      # property without default: n".
      palette.fill.discrete = function(n) vm_pal(n),
      palette.colour.discrete = function(n) vm_pal(n)
    )
}


#' Theme FPB
#'
#' Theme FPB. Based on \code{\link[ggplot2]{theme_bw}}. Sets discrete colour
#' and fill palette defaults to \code{\link{fpb_pal}} via ggplot2 4.0.0 theme
#' entries, and sets the default fill/colour and size of layer geoms (bar,
#' col, point, text, line) to match the FPB palette via the `geom` theme
#' entry introduced in ggplot2 4.0.0 (\code{\link[ggplot2]{element_geom}}) -
#' no \code{update_geom_defaults()} side effect.
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
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      # Reunat & ruudukko
      panel.border        = ggplot2::element_blank(),                         # ei reunalaatikoita (poistaa myös pystyreunat)
      panel.grid.minor    = ggplot2::element_blank(),
      panel.grid.major.y  = ggplot2::element_line(colour = "grey90", linewidth = 0.5),
      panel.grid.major.x  = ggplot2::element_line(colour = "grey95", linewidth = 0.5),
      axis.line.x.top = ggplot2::element_line(colour = "grey60", linewidth = 0.5),

      # Akselit
      axis.ticks          = ggplot2::element_blank(),
      axis.line.y         = ggplot2::element_blank(),                         # ei pystyakseliviivaa
      axis.line.x         = ggplot2::element_line(colour = "grey60", linewidth = 0.5), # hillitty perusviiva alareunaan
      axis.title          = ggplot2::element_text(colour = "grey20", size = ggplot2::rel(0.9)),
      axis.text           = ggplot2::element_text(colour = "grey30"),

      # Facetit (otsikoista tausta ja laatikot pois)
      strip.background    = ggplot2::element_blank(),
      strip.text          = ggplot2::element_text(face = "bold", colour = "grey20"),
      strip.placement     = "outside",

      # Selite
      # legend.position     = "bottom",
      legend.title        = ggplot2::element_text(face = "bold"),
      legend.text         = ggplot2::element_text(size = ggplot2::rel(0.9)),
      legend.background   = ggplot2::element_blank(),
      legend.key          = ggplot2::element_blank(),

      # Otsikot & marginaalit
      plot.title          = ggplot2::element_text(face = "bold", colour = "grey10", size = ggplot2::rel(1.1)),
      plot.subtitle       = ggplot2::element_text(colour = "grey40"),
      plot.caption        = ggplot2::element_text(size = ggplot2::rel(0.8), colour = "grey40"),
      plot.margin         = grid::unit(c(0.6, 0.7, 0.5, 0.6), "cm"),

      # Default fill/colour/size for layer geoms, sourced from the theme
      # itself (ggplot2 4.0.0) instead of a global update_geom_defaults()
      # side effect. Matches the previous bar/col fill, point/text/line
      # colour = fpb_pal(1), point/text size = 4, line linewidth = 1.5.
      geom = ggplot2::element_geom(
        colour = fpb_pal(1),
        fill = fpb_pal(1),
        linewidth = 1.5,
        pointsize = 4,
        fontsize = 4
      ),

      ## Paletti
      palette.fill.discrete = function(n) fpb_pal(n),
      palette.colour.discrete = function(n) fpb_pal(n)
    )
}
