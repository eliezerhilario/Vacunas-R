tablaUI <- function(id, titulo = '') {
  ns <- NS(id)
  # tagList(
    fluidRow(
      box(title = paste0('TABLA ', titulo), status = 'success', solidHeader = T, width = 12, 
          dataTableOutput(ns('tabla')))
    )
  # )
}

tablaServer <- function(id, datos) {
  moduleServer(id, function(input, output, session) {
    output$tabla = renderDataTable(datos)
  })
}