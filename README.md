
<!-- README.md is generated from README.Rmd. Please edit that file -->

# grgylap

<!-- badges: start -->
<!-- badges: end -->

The goal of `grgylap` is to demonstrate the `gargoyle` app using modules
in a package:

## Modules

The modules are stored in `mod_button` and `mod_table`:

    #> R
    #> ├── mod_button.R
    #> └── mod_table.R

## UI & Server

The application UI and server are stored in separate functions:

    #> R
    #> ├── gargoyleServer.R
    #> └── gargoyleUI.R

## Standalone app function

To run the application, use the `launchApp()` function:

    #> R
    #> └── launchApp.R

``` r
library(grgylap)
grgylap::launchApp()
```

# Installation

You can install the development version of `grgylap` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mjfrigaard/grgylap")
```

## Deployed Example

View a deployed version of the application
[here](https://mjfrigaard.shinyapps.io/grgylap/):
