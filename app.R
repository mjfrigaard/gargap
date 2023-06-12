library(shiny)
require(gargoyle)
library(pkgload)
library(rsconnect)

options("gargoyle.talkative" = TRUE)
# run app for package
pkgload::load_all(export_all = TRUE, helpers = TRUE, attach_testthat = TRUE)
library(grgylap)
grgylap::launchApp()
rsconnect::deployApp()
