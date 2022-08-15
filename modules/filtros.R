# Medidas  ----------------------------------------
Hola = setNames(Datos$`COD COBERTURA`, Datos$COBERTURA)
medidas = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')

medidaUI <- function(id, label = 'MEDIDA') {
  ns <- NS(id)
  # tagList(
    column(6,
      selectizeInput(ns('medida'), label = label,
        choices = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')) 
    )
  # )
}

medidaServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    list(medida = reactive({input$medida}))
  })
}


# Filtros ----------------------------------------
filtroUI <- function(id, campo) {
  ns <- NS(id)
  tagList(
    column(6,
      selectizeInput(ns('filtro'), label = campo,
        choice = c('TODAS', Datos %>% distinct(.data[[campo]]))
      )
    )
  )
}

filtroServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # updateSelectInput(session, 'filtro', choices = data, server = T)
    
    list(filtro = reactive(input$filtro))
  })
}
