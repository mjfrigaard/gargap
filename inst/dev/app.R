source("modules.R")
#' Gargoyle App
launchApp <- function() {
  shiny::shinyApp(
    ui = function(request) {
      shiny::tagList(shiny::fluidPage(
        shiny::sidebarLayout(
          shiny::sidebarPanel(shiny::h3(
            shiny::code("gargoyle"), "App"),
            mod_button_ui("button")),
          shiny::mainPanel(
            shiny::fluidRow(
              mod_table_ui("table"),
              # output for reactive values
              shiny::code("gargoyleServer reactives"),
              shiny::verbatimTextOutput("react")
            )
          )
        )
      ))
    },
    server = function(input, output, session) {

      # app reactive values
      output$react <- shiny::renderPrint({
        all_ids <- shiny::reactiveValuesToList(x = input,
                      all.names = TRUE)
        print(unlist(all_ids))
      })

      vals <- mod_button_server(id = "button")

      mod_table_server(id = "table", env_vars = vals)
    }
  )
}
launchApp()
