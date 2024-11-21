#' Set Theme and Scales
#'
#' Set a custom theme and scales using ggcustom. Updates `theme` and discrete
#' color and fill scales with the selected palette.
#'
#' @param theme A ggplot2 theme.
#' @param palette A palette function or the name of a ggcustom palette.
#'    See \code{names(ggcustom_palettes)}.
#' @export
set_gg <- function(theme, palette) {

  # environment for sets
  # environment for sets
  if (!("ggcustom_sets" %in% search())) {
    e <- new.env()
    attach(e, name = "ggcustom_sets", warn.conflicts = FALSE)
  }

  # Validate theme
  if (!inherits(theme, "theme")) {
    stop("The `theme` argument must be a valid ggplot2 theme.")
  }

  # Validate palette
  if (!is.function(palette) && !(palette %in% names(ggcustom_palettes))) {
    stop(paste(palette, "is not a valid palette name for ggcustom_pal"))
  }

  # Set theme
  old_theme <- ggplot2::theme_set(theme)
  assign("old_theme", old_theme,
         pos = "ggcustom_sets")

  # Define palette function
  if (is.function(palette)) {
    pal <- palette
  } else {
    pal <- function(n) ggcustom_pal(n, palette)
  }


  scale_colour_discrete <- function(...) {
    ggplot2::discrete_scale("colour", "ggcustom", pal, ...)
  }

  scale_fill_discrete <- function(...) {
    ggplot2::discrete_scale("fill", "ggcustom", pal, ...)
  }

  assign("scale_colour_discrete", scale_colour_discrete, pos = "ggcustom_sets")
  assign("scale_color_discrete", scale_colour_discrete, pos = "ggcustom_sets")
  assign("scale_fill_discrete", scale_fill_discrete, pos = "ggcustom_sets")
}

#' Reset Theme and Scales
#'
#' @describeIn set_gg Restores the original theme and scales before `set_gg()` was called.
#'
#' @export
unset_gg <- function() {
  if (("ggcustom_sets" %in% search())){
    ggplot2::theme_set(get("old_theme", "ggcustom_sets"))
    detach("ggcustom_sets")
    message("ggcustom unset.")
  }
}


#' Set VM Theme and Palette
#'
#' This is a shortcut function to set the VM theme and palette for `ggplot2` visualizations.
#' It applies the \code{\link{theme_vm}} and sets the default discrete color and fill scales
#' to use the VM palette.
#'
#' @export
#' @examples
#' library(ggplot2)
#' library(ggcustom)
#'
#' # Example dataset
#' data <- data.frame(
#'   category = rep(letters[1:4], each = 3),
#'   value = c(4, 3, 5, 2, 6, 7, 3, 5, 4, 6, 2, 7),
#'   group = rep(1:3, times = 4)
#' )
#'
#' # Define a ggplot object
#' p <- ggplot(data, aes(x = category, y = value, colour = factor(group), group = group)) +
#'   geom_line(size = 1.2) +
#'   geom_point(size = 3)
#'
#' # Apply the VM theme and palette
#' set_vm()
#' p
#'
#' # Reset to original theme and scales
#' unset_gg()

set_vm <- function() {
  set_gg(theme_vm(), "vm")
}
