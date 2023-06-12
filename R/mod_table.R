#' Gargoyle UI table function
#'
#' @param id module id
#'
#' @return module ui function
#'
#' @export
#'
mod_table_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h4(
      shiny::code("Output of z$v")
    ),
    shiny::tableOutput(outputId = ns("evt")),
    shiny::code("mod_table reactives"),
    shiny::verbatimTextOutput(ns("react"))
  )
}

#' Gargoyle UI table function
#'
#' @param id module id
#' @param env_vars output from `mod_button`
#'
#' @return module server function
#'
#' @export
#'
#' @importFrom shiny moduleServer renderPrint reactiveValuesToList
#' @importFrom shiny observe reactive bindEvent renderTable
#' @importFrom gargoyle init trigger on watch
#'
mod_table_server <- function(id, env_vars) {
  shiny::moduleServer(id, function(input, output, session) {
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
