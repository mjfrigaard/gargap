library(shiny)
require(gargoyle)

options("gargoyle.talkative" = TRUE)

mod_gargoyle_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
      shiny::column(width = 12,
      shiny::h4('Go'),
      shiny::actionButton(ns("action_01"), "starwars")),
      shiny::column(width = 12,
      shiny::h4(shiny::code("watch(name = 'tf_01'')")),
      shiny::verbatimTextOutput(ns("tf_01_out"))),
      shiny::hr(),
      shiny::column(width = 12,
      shiny::h4(shiny::code("watch(name = 'tf_02')")),
      shiny::verbatimTextOutput(ns("tf_02_out"))),
      shiny::hr(),
      shiny::column(width = 12,
      shiny::h4(shiny::code("watch(name = 'tf_03')")),
      shiny::verbatimTextOutput(ns("tf_03_out"))),
      shiny::column(width = 6,
      shiny::code("reactive values"),
      shiny::verbatimTextOutput(ns("vals"))
      ),
      shiny::column(width = 6,
        shiny::code("env_vars <- base::new.env()"),
      shiny::verbatimTextOutput(ns("env")))
    # env_vars
  )
}

mod_gargoyle_server <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

  # Initiating the flags
  gargoyle::init("tf_01", "tf_02", "tf_03")

  # env_vars ----
  # Creating a new env to store values, instead of
  # a reactive structure
  env_vars <- base::new.env()

  # the action button triggers the starwars data
  shiny::observe({
    env_vars$df <- dplyr::storms
    # trigger flag 01
    gargoyle::trigger("tf_01")
  }) |>
    shiny::bindEvent(input$action_01)

  output$tf_01_out <- shiny::renderPrint({
    # This part will only render when the tf_01
    # flag is triggered
    gargoyle::watch(name = "tf_01")
    str(env_vars$df)
  })

  # Trigger flag 01 ----
  gargoyle::on("tf_01", {
    # add names
    env_vars$nms <- names(env_vars$df)
    gargoyle::trigger("tf_02")
  })

  output$tf_02_out <- shiny::renderPrint({
    # This part will only render the tf_02 is triggered
    gargoyle::watch(name = "tf_02")
    print(env_vars$nms)
  })

  # on flag 2, trigger flag 3 ----
  gargoyle::on("tf_02", {
    # change
    env_vars$dims <- dim(env_vars$df)
    gargoyle::trigger("tf_03")
  })

  output$tf_03_out <- shiny::renderPrint({
    # This part will only render when tf_03 is triggered
    gargoyle::watch(name = "tf_03")
    names(env_vars)
  })

  output$vals <- shiny::renderPrint({
    all_vals <- reactiveValuesToList(x = input, all.names = TRUE)
    print(all_vals, width = 30, max.levels = NULL)
  })

  output$env <- shiny::renderPrint({
    print(env_vars, width = 30, max.levels = NULL)
  })

  })
}


gargoyleDemoApp <- function() {

  gargoyleUI <- function(request) {
    shiny::tagList(
      shiny::fluidPage(
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::code("gargoyle demo"),
            shiny::verbatimTextOutput(
              outputId = "vals",
              placeholder = TRUE)
          ),
          shiny::mainPanel(
            mod_gargoyle_ui(id = "mod")
            )
          )
      )
    )

  }

  gargoyleServer <- function(input, output, session) {

    mod_gargoyle_server("mod")

    output$vals <- shiny::renderPrint({
      all_vals <- reactiveValuesToList(x = input, all.names = TRUE)
      print(str(all_vals), width = 50, max.levels = NULL)
    })

  }

  shinyApp(ui = gargoyleUI, server = gargoyleServer)
}

gargoyleDemoApp()
