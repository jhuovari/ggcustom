test_that("the_x45 rotates x-axis text", {
  el <- the_x45()
  expect_s3_class(el, "theme")
  expect_identical(el$axis.text.x$angle, 45)
})

test_that("the_legend_bot moves the legend to the bottom", {
  el <- the_legend_bot()
  expect_s3_class(el, "theme")
  expect_identical(el$legend.position, "bottom")
})

test_that("the_title_blank blanks the requested elements", {
  el <- the_title_blank("xyt")
  expect_s3_class(el$axis.title.x, "element_blank")
  expect_s3_class(el$axis.title.y, "element_blank")
  expect_s3_class(el$plot.title, "element_blank")
  expect_null(el$plot.subtitle)
})

test_that("the_title_blank accepts a character vector of codes", {
  el <- the_title_blank(c("l", "c"))
  expect_s3_class(el$legend.title, "element_blank")
  expect_s3_class(el$plot.caption, "element_blank")
})

test_that("the_title_blank defaults to blanking all known titles", {
  el <- the_title_blank()
  expect_s3_class(el$axis.title.x, "element_blank")
  expect_s3_class(el$axis.title.y, "element_blank")
  expect_s3_class(el$plot.title, "element_blank")
  expect_s3_class(el$plot.subtitle, "element_blank")
  expect_s3_class(el$legend.title, "element_blank")
  expect_s3_class(el$plot.caption, "element_blank")
})

test_that("the_title_blank warns on unknown codes and ignores them", {
  expect_warning(el <- the_title_blank("xz"), "Unknown code")
  expect_s3_class(el$axis.title.x, "element_blank")
})

test_that("the_title_blank returns an empty theme when nothing is left to blank", {
  expect_warning(el <- the_title_blank("z"), "Unknown code")
  expect_identical(el, ggplot2::theme())
})
