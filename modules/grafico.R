# Genera el gráfico  ----------------------------------------

graficoUI <- function(id, titulo = '') {
  ns <- NS(id)
  tagList(
    fluidRow(
      box(title = paste0('GRAFICO ', titulo), width = 12, status = 'success', solidHeader = T,
          plotOutput(ns('grafico')))
    )
  )
}

graficoServer <- function(id, datos, x, y, group) {
  moduleServer(id, function(input, output, session) {
    
    # Gráfico
    output$grafico <- renderPlot({
      ggplot(datos, aes({{x}}, {{y}}, group = {{group}}, color = {{group}})) +
      # ggplot(datos, aes(x = .data[[x]], y = .data[[y]], group = .data[[group]], color = .data[[group]])) +
        geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
        scale_y_continuous(labels = comma) + theme_minimal()
    }, res = 96)
  })
}