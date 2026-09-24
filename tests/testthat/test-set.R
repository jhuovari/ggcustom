test_that("set_gg validates its arguments", {
  expect_error(set_gg("not a theme"), "valid ggplot2 theme")
  expect_error(set_gg(ggplot2::theme_bw(), palette = "does_not_exist"),
               "not a valid palette name")
})

test_that("set_gg/unset_gg round-trip the active ggplot2 theme", {
  original_theme <- ggplot2::theme_get()
  on.exit(unset_gg(), add = TRUE)

  set_gg(ggplot2::theme_minimal())
  expect_identical(ggplot2::theme_get()$panel.grid, ggplot2::theme_minimal()$panel.grid)

  unset_gg()
  expect_identical(ggplot2::theme_get(), original_theme)
})

test_that("set_gg with a named palette sets the discrete colour/fill theme entries", {
  on.exit(unset_gg(), add = TRUE)

  set_gg(ggplot2::theme_bw(), palette = "vm")
  active <- ggplot2::theme_get()

  expect_identical(active$palette.colour.discrete(3), vm_pal(3))
  expect_identical(active$palette.fill.discrete(3), vm_pal(3))
})

test_that("set_gg with a palette updates geom defaults and unset_gg restores them", {
  on.exit(unset_gg(), add = TRUE)

  original_point_colour <- ggplot2::GeomPoint$default_aes$colour

  set_gg(ggplot2::theme_bw(), palette = "vm")
  expect_identical(ggplot2::GeomPoint$default_aes$colour, vm_pal(1))

  unset_gg()
  expect_identical(ggplot2::GeomPoint$default_aes$colour, original_point_colour)
})

test_that("set_vm applies the VM theme, palette and geom defaults", {
  on.exit(unset_gg(), add = TRUE)

  set_vm()
  active <- ggplot2::theme_get()

  expect_identical(active$palette.colour.discrete(2), vm_pal(2))
  expect_identical(ggplot2::GeomPoint$default_aes$colour, vm_pal(1))
})

test_that("theme_vm()/theme_fpb() are pure and don't touch geom defaults", {
  original_point_colour <- ggplot2::GeomPoint$default_aes$colour
  original_bar_fill <- ggplot2::GeomBar$default_aes$fill

  invisible(theme_vm())
  invisible(theme_fpb())

  expect_identical(ggplot2::GeomPoint$default_aes$colour, original_point_colour)
  expect_identical(ggplot2::GeomBar$default_aes$fill, original_bar_fill)
})

test_that("plots using theme_vm()/theme_fpb() build without error", {
  # Regression test: vm_pal()/fpb_pal() default `n` to NULL (to support
  # calling them with no arguments), and passing them directly as a
  # theme's palette.*.discrete entry made ggplot2 raise "has NULL property
  # without default: n" when building the plot. See themes.R.
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = factor(cyl))) +
    ggplot2::geom_point()

  expect_no_error(ggplot2::ggplot_build(p + theme_vm()))
  expect_no_error(ggplot2::ggplot_build(p + theme_fpb()))
})

test_that("plots using set_gg()/set_vm() with a palette build without error", {
  on.exit(unset_gg(), add = TRUE)

  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = factor(cyl))) +
    ggplot2::geom_point()

  set_vm()
  expect_no_error(ggplot2::ggplot_build(p))

  unset_gg()
  # vm_pal has a `n = NULL` default; set_gg() must not pass it through to
  # the theme as-is (see the note in set_gg()'s `pal` construction).
  set_gg(ggplot2::theme_bw(), palette = vm_pal)
  expect_no_error(ggplot2::ggplot_build(p))
})
