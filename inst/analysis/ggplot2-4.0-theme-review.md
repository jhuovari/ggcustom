# Evaluation of ggplot2 4.0 theme changes for ggcustom

## Background
The ggcustom package currently provides organisation-specific colour scales
through dedicated scale helpers (e.g. `scale_colour_vm()`) and a global setter
(`set_gg()`) that replaces the default discrete scales by attaching temporary
functions into the search path. The relevant implementations live in
[`R/scales.R`](../R/scales.R) and [`R/set.R`](../R/set.R).

## ggplot2 4.0 theme palette support
Starting from ggplot2 4.0 it is possible to point the default discrete colour
and fill scales to custom palette functions via theme settings. The release
introduces theme entries for discrete palettes, allowing a theme to encapsulate
both the visual styling and the palette choice without overriding global scale
constructors.

## Impact on ggcustom functionality

### `set_gg()` and `unset_gg()`
The current implementation of `set_gg()` attaches replacement definitions for
`scale_colour_discrete()` and `scale_fill_discrete()` into a dedicated
environment that is pushed on the search path, and restores the original
functions in `unset_gg()` by detaching that environment. With ggplot2 4.0 the
same behaviour can be achieved more simply by combining the desired theme with
its palette configuration through the new theme entries. Because the palette can
be provided directly via the theme, there is no longer a need to shadow the
global scale constructors, so the `set_gg()`/`unset_gg()` machinery can be
deprecated in favour of pure theme settings.

### Palette scale helpers in `R/scales.R`
The helpers in `R/scales.R` remain useful even with the new theme capabilities.
They expose palette-specific scale functions (e.g. `scale_fill_vm()`) that can
be added to individual plots regardless of what theme is used. The new theme
behaviour changes the defaults that are used when no explicit scale is supplied
but does not create comparable named helpers. Therefore these wrappers continue
to provide value as ergonomic shortcuts.

## Recommendation
Replace the internals of `set_gg()`/`unset_gg()` with theme-based palette
configuration, but keep the explicit scale helpers exported from `R/scales.R`.
This lets ggcustom benefit from the simpler theme approach while still
supporting users who prefer to add palette-specific scales manually.
