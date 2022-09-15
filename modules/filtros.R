# Medidas ========================================
medidaUI <- function(id, label = 'MEDIDA') {
  ns <- NS(id)
  # tagList(
    column(4,
      selectizeInput(ns('medida'), label = label,
        choices = c('MONTO', 'AUTORIZACIONES', 'MM AUTORIZACION', 'USUARIOS', 'MM USUARIO')) 
    )
  # )
}

medidaServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive({input$medida})
    # list(medida = reactive({input$medida}))
  })
}


# Filtros ========================================
filtroUI <- function(id, campo) {
  ns <- NS(id)
    column(4,
      selectizeInput(ns('filtro'), label = campo, choice = NULL)#, selected = 'TODAS', multiple = T)
    )
}

filtroServer <- function(id, datos, campo) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session, 'filtro', server = T, 
                         choices = c('TODAS', sort(unique(datos[[campo]]))))
    reactive(input$filtro)
    # list(filtro = reactive(input$filtro))
  })
}