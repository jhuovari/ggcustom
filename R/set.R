# Internal environment to store previous theme state
.ggcustom_state <- new.env(parent = emptyenv())

#' Set Theme and Palette Defaults
#'
#' Set a custom theme and palette defaults using ggcustom. Updates `theme` and
#' the discrete colour and fill palettes via ggplot2's theme palette entries
#' when a palette is provided.
#'
#' @param theme A ggplot2 theme.
#' @param palette Optional palette function or the name of a ggcustom palette.
#'    See \code{names(ggcustom_palettes)}. If `NULL`, the supplied `theme`
#'    should already provide palette information (for example via
#'    `palette.<aes>.discrete` theme entries, e.g. `palette.colour.discrete`).
#'    When given, it is also used to set the default fill/colour of the
#'    `bar`, `col`, `point`, `text` and `line` geoms to the palette's first
#'    colour.
#' @export
set_gg <- function(theme, palette = NULL) {

  # Validate theme
  if (!inherits(theme, "theme")) {
    stop("The `theme` argument must be a valid ggplot2 theme.")
  }

  if (!is.null(palette)) {
    # Validate palette
    if (!is.function(palette) && !(palette %in% names(ggcustom_palettes))) {
      stop(paste(palette, "is not a valid palette name for ggcustom_pal"))
    }

    # Define palette function. Always wrap it in a single-argument closure
    # with no default for `n`: ggplot2's theme palette entries inspect the
    # function's formals, and a default of NULL for `n` (as in vm_pal()/
    # fpb_pal(), whose no-argument form returns the full palette) is read
    # as "no usable value", raising "has NULL property without default: n".
    pal <- if (is.function(palette)) {
      function(n) palette(n)
    } else {
      function(n) ggcustom_pal(n, palette)
    }

    # Combine theme with palette defaults introduced in ggplot2 4.0.0
    # (ggplot2's theme() treats "color" and "colour" element names as
    # aliases, so only the "colour" spelling needs to be set here)
    theme <- theme +
      ggplot2::theme(
        palette.fill.discrete = pal,
        palette.colour.discrete = pal
      )

    set_geom_defaults(pal)
  }

  was_set <- isTRUE(get0("is_set", .ggcustom_state, inherits = FALSE))
  previous_theme <- ggplot2::theme_set(theme)

  if (!was_set) {
    assign("old_theme", previous_theme, envir = .ggcustom_state)
  }
  if (!is.null(palette)) {
    assign("geom_defaults_changed", TRUE, envir = .ggcustom_state)
  }
  assign("is_set", TRUE, envir = .ggcustom_state)

  invisible(theme)
}

#' Reset Theme and Palette Defaults
#'
#' @describeIn set_gg Restores the original theme before `set_gg()` was called.
#'
#' @export
unset_gg <- function() {
  if (isTRUE(get0("is_set", .ggcustom_state, inherits = FALSE))) {
    old_theme <- get0("old_theme", .ggcustom_state, inherits = FALSE)
    ggplot2::theme_set(old_theme)
    if (isTRUE(get0("geom_defaults_changed", .ggcustom_state, inherits = FALSE))) {
      ggplot2::reset_geom_defaults()
    }
    rm(list = intersect(c("old_theme", "is_set", "geom_defaults_changed"),
                         ls(.ggcustom_state)),
       envir = .ggcustom_state)
    message("ggcustom unset.")
  }
}

# Set default fill/colour of the bar, col, point, text and line geoms to
# the first colour of `pal`. Used by set_gg()/set_vm() so that the
# side effect only happens when a theme and palette are actually applied,
# not merely when a theme object such as theme_vm() is constructed.
set_geom_defaults <- function(pal) {
  ggplot2::update_geom_defaults("bar", list(fill = pal(1)))
  ggplot2::update_geom_defaults("col", list(fill = pal(1)))
  ggplot2::update_geom_defaults("point", list(size = 4, colour = pal(1)))
  ggplot2::update_geom_defaults("text", list(size = 4, colour = pal(1)))
  ggplot2::update_geom_defaults("line", list(linewidth = 1.5, colour = pal(1)))
  invisible(NULL)
}


#' Set VM Theme and Palette
#'
#' This is a shortcut function to set the VM theme and palette for `ggplot2` visualizations.
#' It applies the \code{\link{theme_vm}}, which already embeds the default discrete colour and fill
#' palettes via the theme settings introduced in ggplot2 4.0.0.
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
  set_gg(theme_vm(), palette = "vm")
}
