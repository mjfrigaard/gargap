## `gargap` (`gar`goyle `a`pp-`p`ackage)

The goal of `gargap` is to demonstrate the [`gargoyle`
package](https://github.com/ColinFay/gargoyle) using modules (within in
a package). Hence the name: **gar**goyle **a**pp-**p**ackage.

Check out the repo for this app [here](https://github.com/mjfrigaard/gargap).

### Modules

The modules are stored in `mod_button` and `mod_table`:

```
R
├── mod_button.R
└── mod_table.R
```

### UI & Server

The application UI and server are stored in separate functions:

```
 R
 ├── gargoyleServer.R
 └── gargoyleUI.R
```

### Standalone app function

To run the application, use the `launchApp()` function:

```
 R
 └── launchApp.R
```

``` r
library(gargap)
gargap::launchApp()
```

## Installation

You can install the development version of `gargap` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mjfrigaard/gargap")
```

### Deployed Example

View a deployed version of the application
[here](https://mjfrigaard.shinyapps.io/gargap/):
