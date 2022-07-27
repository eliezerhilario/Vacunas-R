
server <- function(input, output, session) {
  
# Tab General ==========================================
  ## Gráfico General ---------------------------------------- 
  modSelectIndicadoresServer('general')
  modGraficoServer('general')
  
  ### Datos Gráfico General ---------------------------------------- 
  DatosGraficoGeneral = reactive(DataGraficos(AÑO, MES))
  
  ### Modelo Gráfico por Año ---------------------------------------- 
  GraficoGeneral = function(datos, y) {
    ggplot(datos, aes(x = MES, y = .data[[y]], group = AÑO, color = AÑO)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
  }
  
  
  output$grafico_general <- renderPlot({
    GraficoGeneral(DatosGraficoGeneral(), y = input$indicador_general)
    # ModeloGrafico(data = DatosGraficoGeneral(), x = MES, y = input$indicador_general, group = AÑO, color = AÑO)
  }, res = 96)
  
  
  ## Gráfico General Continuo ----------------------------------------    
  DatosGrafGralCont = reactive(DataGraficos(PERIODO))
  
  ### Modelo Gráfico General Continuo ---------------------------------------- 
  GraficoGralContinuo = function(datos, y) {
    ggplot(datos, aes(x = PERIODO, y = .data[[y]])) +
      geom_line(size = 0.9, color = 'red') + geom_point(size = 3.5, color = 'red') + 
      labs(title = y) + scale_y_continuous(labels = comma) +
      geom_text(aes(label = MONTO), size = 3, position = position_stack(vjust = 1.09)) +
      theme(axis.text.x = element_text(angle = 80))
  }
  
  ### Output Gráfico General Continuo ---------------------------------------- 
  output$grafico_continuo <- renderPlot({
    GraficoGralContinuo(DatosGrafGralCont(), input$indicador_general)
  }, res = 96)
  
  
# Tap Tipo Coberuras ==========================================
  
  ### Datos Gráfico Tipo Cobertura ---------------------------------------- 
  DatosGrafTipoCobertura = reactive(DataGraficos(PERIODO, `TIPO COBERTURA`))
  
  ### Modelo Gráfico Tipo Cobertura ---------------------------------------- 
  GraficoTipoCobertura = function(y) {
    ggplot(DatosGrafTipoCobertura(),
           aes(x = PERIODO, y = .data[[y]], group = `TIPO COBERTURA`, color = `TIPO COBERTURA`)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
    
    # ggplot(DatosGrafTipoCobertura(), 
    #        aes(x = PERIODO, y = .data[[y]], group = `TIPO COBERTURA`, color = `TIPO COBERTURA`)) +
    #   geom_line(size = 0.9, color = 'red') + geom_point(size = 3.5, color = 'red') +
    #   labs(title = y) + scale_y_continuous(labels = comma) +
    #   geom_text(aes(label = MONTO), size = 3, position = position_stack(vjust = 1.09)) +
    #   theme(axis.text.x = element_text(angle = 80))
  }
  
  ### Output Gráfico Tipo Cobertura ---------------------------------------- 
  output$tipo_cobertura <- renderPlot({
    GraficoTipoCobertura(input$tipo_cobertura)
  }, res = 96)
  

# Tap Tipo PSS ==========================================
  
  ### Datos Gráfico Tipo PSS ---------------------------------------- 
  DatosGrafTipoPSS = reactive(DataGraficos(PERIODO, `TIPO RECLAMANTE`))
  
  ### Modelo Gráfico Tipo PSS ---------------------------------------- 
  GraficoTipoPSS = function(y) {
    ggplot(DatosGrafTipoPSS(),
           aes(x = PERIODO, y = .data[[y]], group = `TIPO RECLAMANTE`, color = `TIPO RECLAMANTE`)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
  }
  
  ### Output Gráfico Tipo PSS ---------------------------------------- 
  output$tipo_pss <- renderPlot({
    GraficoTipoPSS(input$tipo_pss)
  }, res = 96)
  
  
# Tap Centros Especializados ==========================================
  
  ### Datos Gráfico Centros Especializados ---------------------------------------- 
  DatosGrafCentrosEspc = reactive(DataGraficos(PERIODO, RECLAMANTE, `TIPO RECLAMANTE`, 'CENTRO ESPECIALIZADO'))
  #   Datos %>% filter(`TIPO RECLAMANTE` == 'CENTRO ESPECIALIZADO') %>% group_by(PERIODO, RECLAMANTE) %>%
  #     summarise(MONTO = sum(`MONTO AUTORIZADO`),
  #               AUTORIZACIONES = n_distinct(INTEGRALIDAD),
  #               `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
  #               USUARIOS = n_distinct(CDPERSON),
  #               `MM USUARIO` = MONTO / USUARIOS
  #     )
  # })
  
  ### Modelo Gráfico Centros Especializados ---------------------------------------- 
  GraficoCentrosEspc = function(y) {
    ggplot(DatosGrafCentrosEspc(),
           aes(x = PERIODO, y = .data[[y]], group = RECLAMANTE, color = RECLAMANTE)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
  }
  
  ### Output Gráfico Tipo PSS ---------------------------------------- 
  output$centros_espec <- renderPlot({
    GraficoCentrosEspc(input$centros_espec)
  }, res = 96)
  
  
  
  
# Tap Coberturas ==========================================
  
  ## Datos Gráfico Coberturas ---------------------------------------- 
  DatosGrafCoberturas = reactive(DataGraficos(PERIODO, COBERTURA))
  
  ## Modelo Gráfico Coberturas ---------------------------------------- 
  GraficoCoberturas = function(y) {
    ggplot(DatosGrafCoberturas(),
           aes(x = PERIODO, y = .data[[y]], group = COBERTURA, color = COBERTURA)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
  }
  
  ## Output Gráfico Cobertura ---------------------------------------- 
  output$coberturas <- renderPlot({
    GraficoCoberturas(input$coberturas)
  }, res = 96)
  
  
  
  
# Tap PSS por Cobertura ==========================================
  
  ## Datos Gráfico PSS por Cobertura ---------------------------------------- 
  DatosGrafPSSCobert = reactive(DataGraficos(PERIODO, COBERTURA))
 
  ## Modelo Gráfico PSS por Cobertura ---------------------------------------- 
  GraficoPSSCobert = function(y) {
    ggplot(DatosGrafPSSCobert(),
           aes(x = PERIODO, y = .data[[y]], group = COBERTURA, color = COBERTURA)) +
      geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
      scale_y_continuous(labels = comma) + theme_minimal()
  }
  
  ## Output Gráfico Cobertura ---------------------------------------- 
  output$pss_cobertura <- renderPlot({
    GraficoPSSCobert(input$pss_cobertura)
  }, res = 96)
  
}