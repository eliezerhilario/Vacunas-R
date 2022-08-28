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

graficoServer <- function(id, datos, x, y, group) {
  moduleServer(id, function(input, output, session) {
    output$grafico <- renderEcharts4r({
      datos %>% group_by({{group}}) %>%
        e_charts(x = {{x}}) %>%
        e_line(serie = {{y}}, symbol = 'circle', symbolSize = 10) %>%
        e_tooltip()
    })
  })
}
