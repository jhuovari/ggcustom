#' Translate all text and factor labels in ggplot2 or patchwork plots
#'
#' `gg_translate()` provides a generic way to translate plot texts,
#' axis labels, legend titles, legend entries, and facet strips
#' in an existing ggplot2 or patchwork plot using a named translation
#' vector.
#'
#' @param plot A `ggplot` or `patchwork` plot object to translate.
#' @param trans A named character vector of translations.
#'   Names correspond to source-language terms and values
#'   to target-language translations.
#'
#' @return A translated plot object of the same type.
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#'   geom_point() +
#'   labs(title = "Car efficiency", colour = "Cylinders")
#'
#' trans <- c("Car efficiency" = "Autotehokkuus",
#'            "Cylinders" = "Sylinterit",
#'            "4" = "4-syl.",
#'            "6" = "6-syl.",
#'            "8" = "8-syl.")
#'
#' gg_translate(p, trans)
#'
#' @export
gg_translate <- function(plot, trans) {

  if (inherits(plot, "patchwork")) {
    # handle patchwork recursively
    patches <- patchwork:::get_patches(plot)
    patches$plots <- rapply(
      patches$plots,
      f = function(p) translator(p, trans),
      classes = "gg",
      how = "replace"
    )
    plot$patches$plots <- patches$plots
    return(plot)
  } else {
    return(translator(plot, trans))
  }
}

#' Internal helper for gg_translate
#'
#' Translates data, labels, scales, and facets inside a single ggplot object.
#'
#' @param plot A ggplot object
#' @param trans A named vector of translations
#' @noRd
translator <- function(plot, trans) {

  # fct_recode expects reversed mapping: new = old
  trans_factor <- stats::setNames(names(trans), unname(trans))

  recode_df <- function(df) {
    if (is.null(df) || !is.data.frame(df)) return(df)
    df |>
      dplyr::mutate(dplyr::across(
        dplyr::where(is.factor),
        ~ forcats::fct_recode(.x, !!!as.list(trans_factor))
      )) |>
      dplyr::mutate(dplyr::across(
        dplyr::where(is.character),
        ~ dplyr::recode(.x, !!!as.list(trans))
      ))
  }

  str_tr <- function(x) {
    if (is.character(x)) {
      stringi::stri_replace_all_fixed(x, names(trans), trans, vectorize_all = FALSE)
    } else x
  }

  if (inherits(plot, "gg")) {

    # 1) Translate data and any layer data
    plot$data <- recode_df(plot$data)
    if (!is.null(plot$layers) && length(plot$layers)) {
      for (i in seq_along(plot$layers)) {
        if (!is.null(plot$layers[[i]]$data)) {
          plot$layers[[i]]$data <- recode_df(plot$layers[[i]]$data)
        }
      }
    }

    # 2) Translate labs
    labs_list <- ggplot2::get_labs(plot)
    labs_list <- purrr::map(labs_list, str_tr)
    plot <- plot + do.call(ggplot2::labs, labs_list)

    # 3) Translate scales
    if (!is.null(plot$scales) && length(plot$scales$scales)) {
      is_waiver <- function(x) inherits(x, "waiver")

      for (j in seq_along(plot$scales$scales)) {
        sc <- plot$scales$scales[[j]]

        # name (legend title)
        if (!is.null(sc$name)) sc$name <- str_tr(sc$name)

        # limits and breaks
        if (!is.null(sc$limits) && is.character(sc$limits)) {
          sc$limits <- stringi::stri_replace_all_fixed(sc$limits, names(trans), trans, vectorize_all = FALSE)
        }
        if (!is.null(sc$breaks) && is.character(sc$breaks)) {
          sc$breaks <- stringi::stri_replace_all_fixed(sc$breaks, names(trans), trans, vectorize_all = FALSE)
        }

        # manual scales: named values (legend keys)
        if (!is.null(sc$values) && !is.null(names(sc$values))) {
          names(sc$values) <- stringi::stri_replace_all_fixed(names(sc$values), names(trans), trans, vectorize_all = FALSE)
        }

        # labels
        if (is.null(sc$labels) || is_waiver(sc$labels)) {
          sc$labels <- function(x) stringi::stri_replace_all_fixed(x, names(trans), trans, vectorize_all = FALSE)
        } else if (is.character(sc$labels)) {
          sc$labels <- stringi::stri_replace_all_fixed(sc$labels, names(trans), trans, vectorize_all = FALSE)
        } else if (is.function(sc$labels)) {
          orig <- sc$labels
          sc$labels <- function(x) {
            out <- orig(x)
            stringi::stri_replace_all_fixed(out, names(trans), trans, vectorize_all = FALSE)
          }
        }

        plot$scales$scales[[j]] <- sc
      }
    }

    # 4) Translate facet labels
    if (!is.null(plot$facet) && !is.null(plot$facet$params$labeller)) {
      base_labeller <- plot$facet$params$labeller
      plot$facet$params$labeller <- function(vars) {
        out <- base_labeller(vars)
        lapply(out, function(v) if (is.character(v)) str_tr(v) else v)
      }
    }
  }

  plot
}
