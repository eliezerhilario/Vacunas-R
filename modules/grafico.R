# Genera el gráfico  ----------------------------------------

graficoUI <- function(id, titulo = '') {
  ns <- NS(id)
  tagList(
    fluidRow(
      box(title = paste0('GRAFICO ', titulo), width = 12, status = 'success', solidHeader = T,
          echarts4rOutput(ns('grafico')))
    )
  )
}

graficoServer <- function(id, datos, x, y, group = NULL) {
  moduleServer(id, function(input, output, session) {
    output$grafico <- renderEcharts4r({
      if(!is.null(group)) datos = datos %>% group_by(.data[[group]])
        datos %>% 
          e_charts_(x) %>%
          e_line_(serie = y, smooth = T, symbol = 'circle', symbolSize = 8) %>%
          e_tooltip() %>%
          e_grid(left = '80', right = '30') %>%
          e_legend(type = c("scroll"), selector = list(
                     list(type = 'inverse', title = 'Invertir'),
                     list(type = 'all', title = 'Todos')
                   )) %>%
          e_show_loading(text = "Procesando", color = "green")
    })
  })
}