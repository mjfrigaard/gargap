#' Gargoyle UI
#'
#' @param request standard shiny args
#'
#' @return shiny server
#'
#' @importFrom shiny tagList fluidPage sidebarLayout
#' @importFrom shiny sidebarPanel h3 code
#' @importFrom shiny fluidRow mainPanel verbatimTextOutput
#'
#' @export
#'
gargoyleUI <- function(request) {
  shiny::tagList(
    shiny::fluidPage(
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::h3(
            shiny::code("gargoyle"), "App"
          ),
          mod_button_ui("button")
        ),
        shiny::mainPanel(
          shiny::fluidRow(
            mod_table_ui("table"),
            shiny::code("gargoyleServer reactives"),
            shiny::verbatimTextOutput("react")
          )
        )
      )
    )
  )
}
