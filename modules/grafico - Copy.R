# Genera el gráfico  ----------------------------------------

graficoUI <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns('grafico'))
  )
}

graficoServer <- function(id, x, y, group) {
  moduleServer(id, function(input, output, session) {
    # Datos Gráficos
    datosGrafico = reactive(dataGraficos(x, group))
  
    # Preparar los datos del gráfico
    dataGraficos = function(x, group = NULL) {
      Datos %>% group_by({{x}}, {{group}}) %>%
        summarise(MONTO = sum(`MONTO AUTORIZADO`),
                  AUTORIZACIONES = n_distinct(INTEGRALIDAD),
                  `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
                  USUARIOS = n_distinct(CDPERSON),
                  `MM USUARIO` = MONTO / USUARIOS,
                  # .groups = "drop"
        )
    }
    
    # Gráfico
    output$grafico <- renderPlot({
      modeloGrafico(datosGrafico(), x, y, group)
    }, res = 96)
    
    # Modelo Gráfico
    modeloGrafico = function(datos, x, y, group) {
      ggplot(datos, aes(x = {{x}}, y = {{y}}, group = {{group}}, color = {{group}})) +
      # ggplot(datos, aes(x = .data[[x]], y = .data[[y]], group = .data[[group]], color = .data[[group]])) +
        geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
        scale_y_continuous(labels = comma) + theme_minimal()
    }
  })
}