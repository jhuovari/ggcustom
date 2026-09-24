# ggcustom 0.1.4

## Bug fixes

* `set_gg()` used the wrong ggplot2 4.0.0 theme entry names
  (`palette.discrete.fill`/`palette.discrete.colour`) when combining a
  `palette` with a theme, so the palette never actually took effect. The
  entries are now set with the correct names (`palette.fill.discrete`,
  `palette.colour.discrete`), matching `theme_vm()`/`theme_fpb()`. The
  redundant `palette.discrete.color` entry was dropped, since ggplot2's
  `theme()` already treats "color" and "colour" as aliases.
* `theme_vm()`/`theme_fpb()` set `palette.fill.discrete`/
  `palette.colour.discrete` to a raw colour vector instead of a palette
  function; they now use `vm_pal()`/`fpb_pal()`, consistent with `set_gg()`.

## Changes

* `theme_vm()` and `theme_fpb()` no longer call `update_geom_defaults()` as
  a side effect of simply constructing the theme object. Building or
  combining these themes (e.g. `p + theme_vm()`) no longer mutates global
  geom defaults.
* Geom defaults (`bar`/`col` fill, `point`/`text`/`line` colour) are now
  set explicitly by `set_gg()`/`set_vm()` when a `palette` is applied, and
  are restored by `unset_gg()` (via `ggplot2::reset_geom_defaults()`)
  alongside the previous theme.
* Removed the unused `Remotes: pttry/ggptt` entry from `DESCRIPTION`.

## Tests

* Added a `testthat` test suite covering the palette helpers
  (`ggcustom_pal()`, `vm_pal()`, `fpb_pal()`), `set_gg()`/`unset_gg()`
  round-tripping, and the `the_title_blank()` helper.

# ggcustom 0.1.3

* Initial tracked version.
