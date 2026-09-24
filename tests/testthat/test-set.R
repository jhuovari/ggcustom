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
