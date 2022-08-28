server <- function(input, output, session) {
  # Tab General ==========================================
  medidaGeneral = medidaServer('general')
  datosGenerales = reactive(consolidado(Datos, MES, AÑO))
  
  observeEvent(medidaGeneral(), {
    tablaServer('general', datosGenerales() %>% select(MES, AÑO, medidaGeneral()))
    graficoServer('general', datosGenerales(), MES, medidaGeneral(), AÑO)
  })

  
  # Tab Tipo Coberturas ==========================================
  medidaTipoCob = medidaServer('tipo_cob')
  filtroTipoCob = filtroServer('tipo_cob', Datos, 'TIPO COBERTURA')
  
  datosTipoCob = reactive(
    consolidado(filtroDatos(Datos, filtroTipoCob(), 'TIPO COBERTURA'), PERIODO, `TIPO COBERTURA`)
  )
  
  observeEvent(c(medidaTipoCob(), filtroTipoCob()), {
    tablaServer('tipo_cob', datosTipoCob() %>% select(PERIODO, `TIPO COBERTURA`, medidaTipoCob()))
    graficoServer('tipo_cob', datosTipoCob(), PERIODO, medidaTipoCob(), `TIPO COBERTURA`)
  })
  
  
  # Tab Tipo PSS ==========================================
  medidaTipoPss = medidaServer('tipo_pss')
  filtroTipoPss = filtroServer('tipo_pss', Datos, 'TIPO RECLAMANTE')
  
  datosTipoPss = reactive(
    consolidado(filtroDatos(Datos, filtroTipoPss(), 'TIPO RECLAMANTE'), PERIODO, `TIPO RECLAMANTE`)
  )
  
  observeEvent(c(medidaTipoPss(), filtroTipoPss()), {
    tablaServer('tipo_pss', datosTipoPss() %>% select(PERIODO, `TIPO RECLAMANTE`, medidaTipoPss()))
  })
  
  
  # Tab Reclamantes ==========================================
  medidaPss = medidaServer('reclamante')
  tipoPssPss = filtroServer('tipo_pss_pss', Datos, 'TIPO RECLAMANTE')
  filtroPss = filtroServer('pss', Datos %>% filter(`TIPO RECLAMANTE` == 'CLINICA'), 'RECLAMANTE')
  # filtroPss = filtroServer('pss', filtro(), 'RECLAMANTE')
  
  filtro = reactive(filtroDatos(datos_TipoPss(), tipoPssPss(), 'TIPO RECLAMANTE'))
  
  datos_TipoPss = reactive(
    filtroDatos(Datos, tipoPssPss(), 'TIPO RECLAMANTE')
  )
  
  datosPss = reactive(
    consolidado(filtroDatos(datos_TipoPss(), filtroPss(), 'RECLAMANTE'), `RECLAMANTE`, PERIODO)
  )

  observeEvent(c(medidaPss(), tipoPssPss(), filtroPss()), {
    tablaServer('reclamante', datosPss() %>% select(PERIODO, `RECLAMANTE`, medidaPss()))
  })
  
  
  # Tab Tipo PSS ==========================================
  medidaTipoPss = medidaServer('tipo_pss')
  filtroTipoPss = filtroServer('tipo_pss', Datos, 'TIPO RECLAMANTE')
  
  datosTipoPss = reactive(
    consolidado(filtroDatos(Datos, filtroTipoPss(), 'TIPO RECLAMANTE'), `TIPO RECLAMANTE`, PERIODO)
  )
  
  observeEvent(c(medidaTipoPss(), filtroTipoPss()), {
    tablaServer('tipo_pss', datosTipoPss() %>% select(PERIODO, `TIPO RECLAMANTE`, medidaTipoPss()))
  })
  
  
  # Tab PSS por Cobertura ==========================================
  medidaPssCob = medidaServer('pss_cob')
  filtroPssCob = filtroServer('pss_cob', Datos, 'COBERTURA')
  
  datosPssCob = reactive(
    consolidado(filtroDatos(Datos, filtroPssCob(), 'COBERTURA'), RECLAMANTE, PERIODO)
  )
  
  observeEvent(c(medidaPssCob(), filtroPssCob()), {
    tablaServer('pss_cob', datosPssCob() %>% select(PERIODO, RECLAMANTE, medidaPssCob()))
  })
}