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
    
    
    
    # GRAFICO DE PRUEBA
    # Prueba %>% group_by(`TIPO RECLAMANTE`) %>%
    #   e_charts(PERIODO) %>%
    #   e_line(serie = MONTO, symbol = 'circle', symbolSize = 10) %>%
    #   e_axis_labels(x = x, y = y) %>% 
    #   e_tooltip() %>% #e_tooltip(trigger = 'axis') %>%
    #   e_grid(right = '30%', left = '80') %>%
    #   e_legend(orient = 'vertical', right = '15', top = '15%',
    #            selector = list(
    #              list(type = 'inverse', title = 'Invertir'),
    #              list(type = 'all', title = 'Todos')
    #            )) 
      # e_legend(right = 0) %>% 
      # e_show_loading(text = "Procesando", color = "green")
      # e_theme("infographic")
      # e_theme("dark")%>%
    #   e_title(text = "Monthly Median Single-Family Home Prices", subtext = "Source: Zillow.com",
    #           sublink = "https://www.zillow.com/research/data/", left = "center"),
    
  })
}