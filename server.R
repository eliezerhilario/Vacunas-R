server <- function(input, output, session) {
  # Tab General ==========================================
  medidaGeneral = medidaServer('general')
  datosGenerales = reactive(consolidado(Datos, 'PERIODO'))
  
  observeEvent(medidaGeneral(), {
    graficoServer('general', datosGenerales(), 'PERIODO', medidaGeneral())
    tablaServer('general', datosGenerales() %>% select(PERIODO, medidaGeneral()))
  })

  
  # Tab Tipo Coberturas ==========================================
  medidaTipoCob = medidaServer('tipo_cob')
  filtroTipoCob = filtroServer('tipo_cob', Datos, 'TIPO COBERTURA')
  
  datosTipoCob = reactive(
    consolidado(
      filtroDatos(Datos, filtroTipoCob(), 'TIPO COBERTURA'), 
      'PERIODO', 'TIPO COBERTURA')
  )
  
  observeEvent(c(medidaTipoCob(), filtroTipoCob()), {
    graficoServer('tipo_cob', datosTipoCob(), 'PERIODO', medidaTipoCob(), 'TIPO COBERTURA')
    tablaServer('tipo_cob', datosTipoCob() %>% select(PERIODO, `TIPO COBERTURA`, medidaTipoCob()))
  })
  
  
  # Tab Tipo Reclamante ==========================================
  medidaTipoPss = medidaServer('tipo_pss')
  filtroTipoPss = filtroServer('tipo_pss', Datos, 'TIPO RECLAMANTE')
  
  datosTipoPss = reactive(
    consolidado(
      filtroDatos(Datos, filtroTipoPss(), 'TIPO RECLAMANTE'), 
      'PERIODO', 'TIPO RECLAMANTE')
  )
  
  observeEvent(c(medidaTipoPss(), filtroTipoPss()), {
    graficoServer('tipo_pss', datosTipoPss(), 'PERIODO', medidaTipoPss(), 'TIPO RECLAMANTE')
    # tablaServer('tipo_pss', datosTipoPss() %>% select(PERIODO, `TIPO RECLAMANTE`, medidaTipoPss()))
  })
  
  
  # Tab Reclamantes ==========================================
  medidaPss = medidaServer('reclamante')
  tipoPssPss = filtroServer('tipo_pss_pss', Datos, 'TIPO RECLAMANTE')
  
  datos_TipoPss = reactive(
    filtroDatos(Datos, tipoPssPss(), 'TIPO RECLAMANTE')
  )
  
  filtroPss = eventReactive(datos_TipoPss(), {
    filtroServer('pss', datos_TipoPss(), 'RECLAMANTE')
  })
  
  datosPss = reactive(
    consolidado(filtroDatos(datos_TipoPss(), filtroPss(), 'RECLAMANTE'), 
                'PERIODO', 'RECLAMANTE')
  )

  observeEvent(c(medidaPss(), tipoPssPss(), filtroPss()), {
    graficoServer('reclamante', datosPss(), 'PERIODO', medidaPss(), 'RECLAMANTE')
    tablaServer('reclamante', datosPss() %>% select(PERIODO, RECLAMANTE, medidaPss()))
  })
  
  
  # Tab Tipo PSS ==========================================
  medidaTipoPss = medidaServer('tipo_pss')
  filtroTipoPss = filtroServer('tipo_pss', Datos, 'TIPO RECLAMANTE')
  
  datosTipoPss = reactive(
    consolidado(filtroDatos(Datos, filtroTipoPss(), 'TIPO RECLAMANTE'), 'PERIODO', 'TIPO RECLAMANTE')
  )
  
  observeEvent(c(medidaTipoPss(), filtroTipoPss()), {
    # tablaServer('tipo_pss', datosTipoPss() %>% select(PERIODO, `TIPO RECLAMANTE`, medidaTipoPss()))
  })
  
  
  # Tab PSS por Cobertura ==========================================
  medidaPssCob = medidaServer('pss_cob')
  filtroPssCob = filtroServer('pss_cob', Datos, 'COBERTURA')
  
  datosPssCob = reactive(
    consolidado(filtroDatos(Datos, filtroPssCob(), 'COBERTURA'), 'PERIODO', 'RECLAMANTE')
  )
  
  observeEvent(c(medidaPssCob(), filtroPssCob()), {
    graficoServer('pss_cob', datosPssCob(), 'PERIODO', medidaPssCob(), 'RECLAMANTE')
    # tablaServer('pss_cob', datosPssCob() %>% select(PERIODO, RECLAMANTE, medidaPssCob()))
  })
}