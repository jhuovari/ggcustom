
# ggcustom

`ggcustom` is an R package that provides custom themes and color scales
for `ggplot2` visualizations, including the VM color palette and theme
as one of the available style options.

## Installation

To install `ggcustom` directly from GitHub, use the `devtools` package:

``` r
# Install devtools if not already installed
install.packages("devtools")

# Install ggcustom from GitHub
devtools::install_github("yourusername/ggcustom")
```

# Overview

The `ggcustom` package is designed to make it easy to apply consistent
themes and color schemes to ggplot2 visualizations. It includes:

- Custom color palettes for FPB and VM.
- Discrete color and fill scales using those palettes.
- FPB and VM themes for ggplot2 plots

# Usage

Once the package is installed, you can load it with:

``` r

library(ggcustom)
```

Color Scales The package includes custom color scales based on the VM
color palette.

``` r

library(ggplot2)

# Example dataset
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]

# Using the VM color scale
ggplot(dsamp, aes(carat, price, colour = clarity)) +
  geom_point() +
  scale_colour_vm()
  
```

You can also use the fill scale for bar plots or other filled
geometries:

``` r

ggplot(dsamp, aes(clarity, fill = clarity)) +
  geom_bar() +
  scale_fill_vm()
  
```

# VM Theme

The theme_vm function provides a customized ggplot2 theme based on
theme_bw, with defaults that make use of the VM color palette.

``` r

# Using the VM theme
p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
p + theme_vm()
```

# Additional Palettes and Themes

The package is structured to allow additional color palettes and themes,
making it easy to expand with other organization-specific styles.

# Examples

``` r

# Scatter plot with VM theme and color scale
ggplot(mtcars, aes(mpg, wt, color = factor(cyl))) +
  geom_point(size = 3) +
  scale_colour_vm() +
  theme_vm()

# Bar plot with VM fill scale
ggplot(mpg, aes(class, fill = class)) +
  geom_bar() +
  scale_fill_vm() +
  theme_vm()
  
```

Contributing Contributions are welcome! If you’d like to add new color
palettes, themes, or functionality, please submit a pull request or open
an issue.

License ggcustom is licensed under the MIT License.
