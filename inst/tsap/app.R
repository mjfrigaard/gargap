library(shiny)
library(gargoyle)
# remotes::install_github("mjfrigaard/tsap")
library(tsap)
source("modules.R")
source("appUI.R")
source("appServer.R")

demoApp <- function() {
  shiny::shinyApp(
    ui = appUI,
    server = appServer
  )
}
demoApp()
