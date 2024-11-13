# R/ggcustom_palettes.R

# Define the collection of color palettes for ggcustom
ggcustom_palettes <- list(
  # Ministry of Finance
  vm = c("#006475", "#c48903", "#365ABD", "#0098e8", "#1B396D", "#00959B"),
  # Finnish Productivity Board
  fpb = c("#0072B2", "#fc7d0b", "#109618", "grey45", "#c85200", "#5fa2ce", "#f4c623", "#b8c9dc", "#6c905e", "#8B3E2F", "#8968CD", "#cd3122", "grey75")
)

#' Color palettes in ggcustom package.
#'
#' Color palettes in the ggcustom package (discrete).
#'
#' Colors in palettes are recycled if needed (with warning).
#'
#' Available palettes are: vm.
#'
#' @param n A number of colors needed. NULL (default) returns all available colors.
#' @param name A name of the palette. See \code{names(ggcustom_palettes)}.
#' @param last_grey Logical, if TRUE, the last color will be replaced with "grey75".
#' @export
#' @examples
#' scales::show_col(ggcustom_pal(n = 6, name = "vm"))
#' scales::show_col(ggcustom_pal(n = 6, name = "fpb"))
ggcustom_pal <- function(n = NULL, name, last_grey = FALSE) {
  cols <- ggcustom_palettes[[name]]
  if (is.null(cols)) stop(name, " is not a valid palette name for ggcustom_pal")
  if (is.null(n)) n <- length(cols)
  if (n > length(cols))
    warning("n is greater than maximum number of colors in the ", name,
            " palette. Colors are recycled")
  col_seg <- rep(1:length(cols), times = ceiling(n / length(cols)))[1:n]
  cols <- cols[col_seg]

  if (last_grey) cols <- c(cols[-length(cols)], "grey75")
  cols
}

#' VM Color Palette
#'
#' Color palette for VM (discrete).
#'
#' Provides the VM color palette with colors recycled if needed (with warning).
#'
#' @param n A number of colors needed.
#' @export
#' @examples
#' scales::show_col(vm_pal(6))
vm_pal <- function(n = NULL) {
  ggcustom_pal(n, "vm")
}

#' @describeIn vm_pal VM palette with the last color grey.
#' @export
#'
vm_pal_lg <- function(n = NULL) {
  ggcustom_pal(n, "vm", last_grey = TRUE)
}

#' Finnish Productivity Board Color Palette
#'
#' Color palette for Finnish Productivity Board (discrete).
#'
#' Provides the VM color palette with colors recycled if needed (with warning).
#'
#' @param n A number of colors needed.
#' @export
#' @examples
#' scales::show_col(vm_pal(6))
fpb_pal <- function(n = NULL) {
  ggcustom_pal(n, "fpb")
}

#' @describeIn fpb_pal Finnish Productivity Board palette with the last color grey.
#' @export
#'
fpb_pal_lg <- function(n = NULL) {
  ggcustom_pal(n, "fpb", last_grey = TRUE)
}
