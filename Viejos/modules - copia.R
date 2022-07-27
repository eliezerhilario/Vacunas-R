# MODULOS ================================================

## Modulo modSelectIndicadores para seleccionar los indicadores a mostrar  ----------------------------------------
modSelectIndicadoresUI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(4,
             selectInput(ns('indicadores'), label = 'INDICADORES', 
                choices = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')))
    )
  )
}

modSelectIndicadoresServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    return(indicadores = reactive(input$indicadores))
  })
}


## Modulo modGrafico para generar el gráfico  ----------------------------------------
modGraficoUI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      box(title = 'Gráfico', width = 12, status = 'success', solidHeader = T, 
          plotOutput(ns('grafico'))))
  )
}

modGraficoServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Preparar los datos del gráfico
    datosGrafico = reactive(dataGraficos(AÑO, MES))
    
    # Generar el gráfico
    output$grafico <- renderPlot({
      modeloGrafico(datosGrafico(), x = MES, y = input$indicadores, group = AÑO)
    }, res = 96)
    
  })
}



## Datos Graficos ---------------------------------------- 
dataGraficos = function(x, y = NULL) {
  Datos %>% group_by({{x}}, {{y}}) %>%
    summarise(MONTO = sum(`MONTO AUTORIZADO`),
              AUTORIZACIONES = n_distinct(INTEGRALIDAD),
              `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
              USUARIOS = n_distinct(CDPERSON),
              `MM USUARIO` = MONTO / USUARIOS, 
              .groups = "drop"
    )
}


## Modelo Gráfico ---------------------------------------- 
modeloGrafico = function(datos, x, y, group) {
  ggplot(datos, aes(x = .data[[x]], y = .data[[y]], group = .data[[group]], color = .data[[group]])) +
    geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
    scale_y_continuous(labels = comma) + theme_minimal()
}



bodyUI = 
  function(id, labelSelect = 'INDICADOR', labelBox = 'Gráfico', widthBox = 12, grafContinuo = 0) {
    ns = NS(id)
    tagList(
      fluidRow(
        column(4,
               selectInput(ns('indicadores'), label = labelSelect, 
                 choices = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO', 'Modulos')))
      ),
      fluidRow(
        box(title = labelBox, width = widthBox, status = 'success', solidHeader = T, 
            plotOutput(ns('grafico')))
      ),
      if (grafContinuo) {
        fluidRow(
          box(title = 'Gráfico', status = 'success',  width = 12, solidHeader = T, 
              plotOutput(ns('grafico_continuo'))))
      }
    )
  }


bodyServer = function(id){
  moduleServer(id, function(input, output, session) { 
    
    ## Datos Graficos ---------------------------------------- 
    M_DataGraficos = function(x, y = NULL) {
      Datos %>% group_by({{x}}, {{y}}) %>%
        summarise(MONTO = sum(`MONTO AUTORIZADO`),
                  AUTORIZACIONES = n_distinct(INTEGRALIDAD),
                  `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
                  USUARIOS = n_distinct(CDPERSON),
                  `MM USUARIO` = MONTO / USUARIOS, 
                  .groups = "drop"
        )
    }
    
    ## Datos Gráfico General ---------------------------------------- 
    M_DatosGrafico = reactive(M_DataGraficos(AÑO, MES))
    
    output$grafico <- renderPlot({
      GraficoPorAnio(M_DatosGrafico(), y = input$indicadores, group)
    }, res = 96)
  })
}
    

# MODELOS ================================================

## Modelo Gráfico General ---------------------------------------- 
M_ModeloGrafico = function(data, x, y, group = NULL, color = NULL) {
  ggplot(data, aes(x = .data[[x]], y = .data[[y]], group, color)) +
    geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) + 
    scale_y_continuous(labels = comma) + theme_minimal()
}

## Modelo Gráfico por Año ---------------------------------------- 
GraficoPorAnio = function(datos, y) {
  ggplot(datos, aes(x = MES, .data[[y]], group = AÑO, color = AÑO)) +
    geom_line(size = 0.9) + geom_point(size = 3.5) + labs(title = y) +
    scale_y_continuous(labels = comma) + theme_minimal()
}