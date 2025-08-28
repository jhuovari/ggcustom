#' Theme elements helpers
#'
#' Convenient shortcuts for modifying theme elements with
#' \code{\link[ggplot2]{theme}}.
#'
#' @section Shortcuts:
#' \itemize{
#'   \item \code{the_x45()}: rotate x-axis text by 45 degrees (uses \code{hjust = 1, vjust = 1}).
#'   \item \code{the_legend_bot()}: move legend to bottom.
#'   \item \code{the_title_blank()}: blank selected title elements.
#' }
#'
#' @details
#' For \code{the_title_blank()}, the \code{blanks} argument can be provided as
#' a character vector of initial letters or a single concatenated string.
#' Valid codes are:
#' \itemize{
#'   \item \code{"x"} = \code{axis.title.x}
#'   \item \code{"y"} = \code{axis.title.y}
#'   \item \code{"t"} = \code{plot.title}
#'   \item \code{"l"} = \code{legend.title}
#'   \item \code{"c"} = \code{plot.caption}
#' }
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
#' p + the_x45()
#' p + the_legend_bot()
#' p + the_title_blank("xyt")       # blanks x/y axis titles and plot title
#' p + the_title_blank(c("l","c"))  # blanks legend title and caption
#' }
#'
#' @name theme_helpers
NULL

#' @describeIn theme_helpers rotate x-axis labels by 45 degrees
#' @export
the_x45 <- function() {
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1, vjust = 1))
}

#' @describeIn theme_helpers legend.position = "bottom"
#' @export
the_legend_bot <- function() {
  ggplot2::theme(legend.position = "bottom")
}

#' @describeIn theme_helpers blank selected title elements
#' @param blanks In \code{the_title_blank} a vector of initials for blank titles.
#'   Default is all titles: \code{c("x","y","t","l","c")} for x-axis, y-axis,
#'   plot title, legend title and caption. A concatenated string like \code{"xyt"}
#'   also works.
#' @export
the_title_blank <- function(blanks = c("x", "y", "t", "l", "c")) {
  # Accept "xyt" or c("x","y","t")
  if (length(blanks) == 1L) blanks <- unlist(strsplit(blanks, "", fixed = TRUE))

  # Map codes to element names
  key <- c(x = "axis.title.x",
           y = "axis.title.y",
           t = "plot.title",
           l = "legend.title",
           c = "plot.caption")

  # Validate and filter
  bad <- setdiff(blanks, names(key))
  if (length(bad)) {
    warning("Unknown code(s) in 'blanks': ", paste(bad, collapse = ", "),
            ". Allowed: ", paste(names(key), collapse = ", "))
  }
  wanted <- unique(key[intersect(blanks, names(key))])

  # Nothing to blank
  if (length(wanted) == 0L) return(ggplot2::theme())

  # Build element list and call theme
  blank_list <- stats::setNames(
    replicate(length(wanted), ggplot2::element_blank(), simplify = FALSE),
    wanted
  )
  do.call(ggplot2::theme, blank_list)
}
