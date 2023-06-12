#' Gargoyle UI button function
#'
#' @param id module id
#'
#' @return module ui function
#'
#' @export
#'
#' @importFrom shiny NS tagList h4 actionButton code
#' @importFrom shiny p verbatimTextOutput hr strong
#'
mod_button_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::hr(),
    shiny::strong("Go"),
    shiny::actionButton(
      inputId = ns("y"),
      shiny::strong(shiny::code("input$y"))
    ),
    shiny::p(shiny::code("mod_button reactives")),
    shiny::verbatimTextOutput(ns("react"))
  )
}

#' Gargoyle UI button function
#'
#' @param id module id
#'
#' @return module server function
#'
#' @export
#'
#' @importFrom shiny moduleServer renderPrint reactiveValuesToList
#' @importFrom shiny observe reactive bindEvent
#' @importFrom gargoyle init trigger on
#'
mod_button_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
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
