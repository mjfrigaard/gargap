library(shiny)
require(gargoyle)

#' Gargoyle UI button function
mod_button_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::hr(),
    shiny::strong("Go"),
    shiny::actionButton(
      inputId = ns("y"),
      shiny::strong(shiny::code("input$y"))
    ),
    # output for module reactive values
    shiny::p(shiny::code("mod_button reactives")),
    shiny::verbatimTextOutput(ns("react"))
  )
}

#' Gargoyle UI button function
mod_button_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    # module reactive values
    output$react <- shiny::renderPrint({
      all_ids <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
      print(unlist(all_ids))
    })

    gargoyle::init("airquality", "iris")
    z <- new.env()

    shiny::observe({
      z$v <- mtcars
      gargoyle::trigger("airquality")
    }) |>
      shiny::bindEvent(input$y)

    gargoyle::on("airquality", {
      z$v <- airquality
      gargoyle::trigger("iris")
    })

    return(
      shiny::reactive({
        list(
          v = z$v
        )
      }) |>
        shiny::bindEvent(input$y)
    )
  })
}


#' Gargoyle UI table function
mod_table_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h4(
      shiny::code("Output of z$v")
    ),
    shiny::tableOutput(outputId = ns("evt")),
    # output for module reactive values
    shiny::code("mod_table reactives"),
    shiny::verbatimTextOutput(ns("react"))
  )
}

#' Gargoyle UI table function
mod_table_server <- function(id, env_vars) {
  shiny::moduleServer(id, function(input, output, session) {
    # module reactive values
    output$react <- shiny::renderPrint({
      all_ids <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
      print(unlist(all_ids))
    })

    gargoyle::init("iris", "renderiris")
    z <- new.env()

    shiny::observe({
      z$v <- env_vars()$v
      gargoyle::trigger("iris")
    }) |>
      shiny::bindEvent(env_vars())

    gargoyle::on("iris", {
      z$v <- iris
      gargoyle::trigger("renderiris")
    })

    output$evt <- shiny::renderTable({
      gargoyle::watch(name = "renderiris")
      head(z$v)
    })
  })
}
