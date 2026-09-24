test_that("ggcustom_pal returns the requested number of colours", {
  cols <- ggcustom_pal(n = 4, name = "vm")
  expect_length(cols, 4)
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", cols)))
})

test_that("ggcustom_pal returns all colours when n is NULL", {
  expect_identical(ggcustom_pal(name = "vm"), ggcustom_palettes[["vm"]])
  expect_identical(ggcustom_pal(name = "fpb"), ggcustom_palettes[["fpb"]])
})

test_that("ggcustom_pal recycles colours with a warning when n is too large", {
  n_vm <- length(ggcustom_palettes[["vm"]])
  expect_warning(cols <- ggcustom_pal(n = n_vm + 2, name = "vm"), "recycled")
  expect_length(cols, n_vm + 2)
  expect_identical(cols[seq_len(2)], cols[n_vm + seq_len(2)])
})

test_that("ggcustom_pal errors on an unknown palette name", {
  expect_error(ggcustom_pal(name = "does_not_exist"), "not a valid palette name")
})

test_that("last_grey replaces only the last colour", {
  cols <- ggcustom_pal(n = 5, name = "vm", last_grey = TRUE)
  expect_length(cols, 5)
  expect_identical(cols[5], "grey75")
  expect_identical(cols[-5], ggcustom_pal(n = 5, name = "vm")[-5])
})

test_that("vm_pal/fpb_pal wrap ggcustom_pal for the right palette", {
  expect_identical(vm_pal(3), ggcustom_pal(3, "vm"))
  expect_identical(fpb_pal(3), ggcustom_pal(3, "fpb"))
  expect_identical(vm_pal_lg(3), ggcustom_pal(3, "vm", last_grey = TRUE))
  expect_identical(fpb_pal_lg(3), ggcustom_pal(3, "fpb", last_grey = TRUE))
})
