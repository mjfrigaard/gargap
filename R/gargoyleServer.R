#' Gargoyle Server
#'
#' @param input standard shiny args
#' @param output standard shiny args
#' @param session standard shiny args
#'
#' @return shiny server.
#'
#' @importFrom shiny reactiveValuesToList
#'
#' @export
#'
gargoyleServer <- function(input, output, session) {
  output$react <- shiny::renderPrint({
    all_ids <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
    print(unlist(all_ids))
  })

  vals <- mod_button_server(id = "button")

  mod_table_server(id = "table", env_vars = vals)
}
