server <- function(input, output, session) {
  # Tab General ==========================================

  medidaGeneral = medidaServer('general')
  
  datosGenerales = reactive(data(Datos, AÑO, PERIODO))
  
  observeEvent(medidaGeneral$medida(), {
    tablaServer('general', datosGenerales() %>% 
                  select(PERIODO, AÑO, medidaGeneral$medida()))

    # graficoServer('general',
    #               datos = datosGenerales(),
    #               x = factor('PERIODO'),
    #               y = medidaGeneral$medida(),
    #               group = 'AÑO')
  })

  # Tab Tipo Coberturas ==========================================
    
  medidaTipoCob = medidaServer('tipo_cob')
  filtroTipoCob = filtroServer('tipo_cob')

  filtroDatosTipoCob = reactive(
    if (filtroTipoCob$filtro() == 'TODAS') Datos else
      Datos %>% filter(`TIPO COBERTURA` == filtroTipoCob$filtro())
  )
  
  datosTipoCob = reactive(
    data(filtroDatosTipoCob(), `TIPO COBERTURA`, PERIODO)
  )
  
  observeEvent(c(medidaTipoCob$medida(), filtroTipoCob$filtro()), {
    tablaServer('tipo_cob', datosTipoCob() %>% 
                  select(PERIODO, `TIPO COBERTURA`, medidaTipoCob$medida()))
  })
  
  
  # Tab Tipo PSS ==========================================
  medidaTipoPSS = medidaServer('tipo_pss')
  filtroTipoPSS = filtroServer('tipo_pss')
  
  filtroDatosTipoPSS = reactive(
    if (filtroTipoPSS$filtro() == 'TODAS') Datos else
      Datos %>% filter(`TIPO RECLAMANTE` == filtroTipoPSS$filtro())
  )
  
  datosTipoPSS = reactive(
    data(filtroDatosTipoPSS(), `TIPO RECLAMANTE`, PERIODO)
  )
  
  observeEvent(c(medidaTipoPSS$medida(), filtroTipoPSS$filtro()), {
    tablaServer('tipo_pss', datosTipoPSS() %>% 
                  select(PERIODO, `TIPO RECLAMANTE`, medidaTipoPSS$medida()))
  })
  
  
  # Tab Centros Especializados ==========================================
  
  medidaCentroEsp = medidaServer('centros_esp')
  filtroPSS = filtroServer('pss')
  
  filtroDatosCentroEsp = reactive(
    if (filtroPSS$filtro() == 'TODAS') {
      Datos %>% filter(`TIPO RECLAMANTE` == 'CENTRO ESPECIALIZADO') 
    } else {
      Datos %>% filter(`TIPO RECLAMANTE` == 'CENTRO ESPECIALIZADO', `RECLAMANTE` == filtroPSS$filtro())
    }
  )
  
  datosCentroEsp = reactive(
    data(filtroDatosCentroEsp(), `RECLAMANTE`, PERIODO)
  )

  observeEvent(c(medidaCentroEsp$medida(),datosCentroEsp()), {
    tablaServer('centros_esp', datosCentroEsp() %>%
                  select(PERIODO, `RECLAMANTE`, medidaCentroEsp$medida()))
  })
}