#' Gargoyle App
#'
#'
#' @return shiny app
#'
#' @importFrom shiny shinyApp
#' @import gargoyle
#'
#' @export launchApp
launchApp <- function() {
  shiny::shinyApp(
    ui = gargoyleUI,
    server = gargoyleServer
  )
}
